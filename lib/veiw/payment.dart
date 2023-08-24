import 'package:doctor/provid/prov.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

//import '../getxserver/mangeserver.dart';

class paymentpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _paymentpage();
  }
}

class _paymentpage extends State<paymentpage> {
  int num = 20;
  List id = [];
  bool res = true;
  late Box idbox = Hive.box("idresep");
  @override
  void initState() {
    // if (idbox.get('id') == null) {
    //   idbox.put("id", "0");
    // }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getpaymettoday();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xf3f3f3f3f3),
      body: Row(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              child: Consumer<changedata>(builder: (context, val, child) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: val.listpatientstoday.length,
                  itemBuilder: (context, i) {
                    val.displaypatient(i);
                    return Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(30),
                      height: 250,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Consumer<changedata>(
                        builder: (context, val, child) {
                          return Center(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      val.getidpatient(int.parse(
                                          val.listpatientstoday[i].idpatient));

                                      Navigator.of(context)
                                          .pushNamed('datapatient');
                                    },
                                    child: Text(
                                      '${val.listpatientstoday[i].name}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: val.listpaymenttoday.length,
                                    itemBuilder: (context, j) {
                                      return val.listpaymenttoday[j]
                                                  .idpatient ==
                                              val.listpatientstoday[i].idpatient
                                          ? Container(
                                              margin: EdgeInsets.all(5),
                                              child: Card(
                                                  child: ListTile(
                                                title: Text(
                                                  '${val.listpaymenttoday[j].why}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                trailing: Text(
                                                  '${val.listpaymenttoday[j].salary}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )))
                                          : Container();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ),
          ///////////////////////////////////////
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 10),
              height: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
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
                      keyboardType: TextInputType.number,
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
                            Navigator.of(context)
                                .pushReplacementNamed('paymentpage');
                          },
                          leading: Icon(Icons.money),
                          trailing: Text("${val.monytoday}"),
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
      
    );
  }

  ///////////////////////////////////////////////////////////////////add pationt
  Future<void> desplaydata() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Consumer<changedata>(builder: (context, val, child) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Provider.of<changedata>(context, listen: false).getonepatient();
          });
          return AlertDialog(
            scrollable: true,
            title: const Text('data'),
            elevation: 10,
            content: Column(
              children: [
                Text(
                  '${val.listonepatiebt[0].name}',
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'num:${val.listonepatiebt[0].idpatient}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Phone: ${val.listonepatiebt[0].phone}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Age: ${val.listonepatiebt[0].age}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Date: ${val.listonepatiebt[0].date}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        });
      },
    );
  }

  Future<void> _addpationt() async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Consumer<changedata>(builder: (context, val, child) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Add Patient'),
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
                  ),
                  TextFormField(
                    controller: val.agef,
                    decoration: InputDecoration(
                        label: Text('age'), prefixIcon: Icon(Icons.av_timer)),
                  ),
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
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            Provider.of<changedata>(context, listen: false)
                                .getpatientstoday();
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
