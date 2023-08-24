import 'package:doctor/provid/prov.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';

import 'package:provider/provider.dart';

class home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _home();
  }
}

class _home extends State<home> {
  int num = 20;
  List<int> id = [];
  late Box idbox = Hive.box("idresep");
  @override
  void initState() {
    if (idbox.get('id') == null) {
      idbox.put("id", "0");
    }
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getpaymettoday();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "home",
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   backgroundColor: Colors.white,
      // ),
      backgroundColor: Color(0xf3f3f3f3f3),
      body: Row(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              child: Consumer<changedata>(builder: (context, val, child) {
                return GridView.builder(
                    // controller: ScrollController(
                    //     initialScrollOffset: val.mypatient.length / 4 * 200),
                    // reverse: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemCount: val.mypatient.length,
                    itemBuilder: (context, i) {
                      //////////add List idpatient

                      val.displaypatient(i);
                      //ids[0] = int.parse(val.lpatient.idpatient);
                      //id.add(int.parse(val.lpatient.idpatient));

                      return Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(30),
                        height: 250,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Consumer<changedata>(
                          builder: (context, val, child) {
                            return MaterialButton(
                              //button person

                              onPressed: () {
                                val.getidpatient(i);
                                print(i);

                                Navigator.of(context)
                                    .pushReplacementNamed('datapatient');
                              },
                              child: Center(
                                child: SingleChildScrollView(
                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Color.fromARGB(
                                              255, 246, 236, 150),
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.black,
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '${val.lpatient.name}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        ' ${val.lpatient.idpatient} ',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    });
              }),
            ),
          ),
          ///////////////////////////////////////
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(30),
              height: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  //connect server /////////////////////////////////////////
                  Consumer<changedata>(builder: (context, val, child) {
                    return val.clientmodel == null ||
                            !val.clientmodel!.isConnected
                        ? val.address == null
                            ? Text(
                                "no device found",
                                style: TextStyle(color: Colors.red),
                              )
                            : Card(
                                color: Colors.white,
                                child: ListTile(
                                  onTap: () async {
                                    await val.clientmodel!.connect();

                                    // val.sendMessage(
                                    //     'hai server iam client connnect to you');
                                    setState(() {});
                                    print('con');
                                  },
                                  title: Text("Desktop"),
                                  subtitle: Text('${val.address!.ip}'),
                                ),
                              )
                        : Text(
                            'connected to ${val.clientmodel!.hostName}',
                            style: TextStyle(color: Colors.green),
                          );
                  }),
                  //seerch
                  Consumer<changedata>(builder: (context, val, child) {
                    return Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //Container(child: Text('${val.test}'),),
                          Container(
                              margin: EdgeInsets.all(10),
                              child: CircularProgressIndicator(
                                value: val.test.toDouble() / 30,
                                color: Colors.black,
                                strokeWidth: 4,
                              )),
                          Container(
                            color: Colors.grey.shade300,
                            child: MaterialButton(
                              onPressed: () => val.test == 30 || val.test == 0
                                  ? val.getIpAddress()
                                  : null,
                              child: Row(
                                children: [
                                  Icon(Icons.search),
                                  Text("Search"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  Consumer<changedata>(builder: (context, val, child) {
                    return TextFormField(
                      inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'\d')),
                    ],
                      controller: val.search,
                      decoration: InputDecoration(
                        label: Text('Id Patient'),
                        prefixIcon: IconButton(
                            ///////////icon search
                            onPressed: () {
                              val.getsearch();
                              if (val.find == 1) {
                                int i = int.parse(
                                    val.listpatientsearch[0].idpatient);
                                val.getidpatient(i);

                                Navigator.of(context).pushNamed('datapatient');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Not Fount Patient'),
                                    duration: Duration(seconds: 2),
                                    action: SnackBarAction(
                                      label: 'Doctor',
                                      onPressed: () {},
                                    ),
                                  ),
                                );
                              }
                            },
                            icon: Icon(
                              Icons.person_search,
                              color: Colors.black,
                            )),
                      ),
                    );
                  }),
                  SizedBox(
                    height: 30,
                  ),
                  Consumer<changedata>(builder: ((context, val, child) {
                    return Card(
                      color:
                          val.screen == 1 ? Colors.grey.shade300 : Colors.white,
                      elevation: 10,
                      child: ListTile(
                        onTap: () {
                          val.patienttodayscreen();
                          Navigator.of(context)
                              .pushReplacementNamed('patienttoday');
                        },
                        leading: Icon(Icons.co_present),
                        title: Text(
                          'Patients Today',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  })),
                  Consumer<changedata>(
                    builder: ((context, val, child) {
                      return Card(
                        color: val.screen == 4
                            ? Colors.grey.shade300
                            : Colors.white,
                        elevation: 10,
                        child: ListTile(
                          onTap: () {
                            val.patientsscreen();
                            Navigator.of(context).pushReplacementNamed('home');
                          },
                          leading: Icon(Icons.people),
                          title: Text(
                            'Patients',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }),
                  ),
                  Consumer<changedata>(
                    builder: ((context, val, child) {
                      return Card(
                        color: val.screen == 5
                            ? Colors.grey.shade300
                            : Colors.white,
                        elevation: 10,
                        child: ListTile(
                          onTap: () {
                            val.paymentscreen();
                            Navigator.of(context).pushReplacementNamed('paymentpage');
                          },
                          trailing: Text("${val.monytoday}"),
                          leading: Icon(Icons.money),
                          title: Text(
                            'Paymenttoday',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }),
                  ),
                  Consumer<changedata>(
                    builder: ((context, val, child) {
                      return Card(
                        color: val.screen == 6
                            ? Colors.grey.shade300
                            : Colors.white,
                        elevation: 10,
                        child: ListTile(
                          onTap: () {
                            val.pationt_onlinescreen();
                            Navigator.of(context)
                                .pushReplacementNamed('pationt_online');
                          },
                          leading: Icon(Icons.online_prediction),
                          title: Text(
                            'pationt_online',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      /////////////////////////////////////////////////
      floatingActionButton:
          Consumer<changedata>(builder: (context, val, child) {
        return val.clientmodel == null || !val.clientmodel!.isConnected
            ? FloatingActionButton(
                backgroundColor: Colors.white,
                elevation: 20,
                onPressed: () {
                  _addpationt();
                },
                child: Icon(
                  Icons.person_add,
                  color: Colors.black,
                ))
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    radius: 30,
                    child: Consumer<changedata>(builder: (context, val, child) {
                      return IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          val.getpatientstoday_sendto();
                        },
                      );
                    }),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    radius: 30,
                    child: IconButton(
                      icon: Icon(
                        Icons.person_add,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        _addpationt();
                      },
                    ),
                  ),
                ],
              );
      }),
    );
  }

  ///////////////////////////////////////////////////////////////////add pationt
  Future<void> _addpationt() async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Consumer<changedata>(builder: (context, val, child) {
          return AlertDialog(
            scrollable: true,
            title: const Text(
              'Add Patient',
            ),
            elevation: 10,
            content: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: val.namef,
                    decoration: InputDecoration(
                        label: Text('Name'),
                        prefixIcon: Icon(Icons.attribution)),
                  ),
                  TextFormField(
                    controller: val.phonef,
                    //initialValue: '01',
                    decoration: InputDecoration(
                        label: Text('Phone'), prefixIcon: Icon(Icons.phone)),
                        inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'\d')),
                    ],
                  ),
                  TextFormField(
                    controller: val.agef,
                    decoration: InputDecoration(
                        label: Text('age'), prefixIcon: Icon(Icons.av_timer)),
                        inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'\d')),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050),
                        ).then((value) {
                          if (value != null) {
                            val.dateenter = value.toString();
                            val.dateenter =
                                Jiffy.parse('${val.dateenter}').yMd;

                            //print(val.daterepeat);
                            //val.adddaterepeat();
                          }
                        });
                      },
                      icon: Icon(Icons.date_range)),
                ],
              ),
            ),
            actions: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: Consumer<changedata>(
                  builder: (context, value, child) {
                    return IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (val.namef.text != '') {
                          val.addpatient();
                          Navigator.of(context).pop();
                          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                            Provider.of<changedata>(context, listen: false).getpatientstoday();
                          });
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          );
        });
      },
    );
  }
}
