import 'package:doctor/provid/prov.dart';
import 'package:doctor/veiw/printdatapatient.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';

import 'package:provider/provider.dart';
//import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class datapationt extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _datapationt();
  }
}

class _datapationt extends State<datapationt> {
  late Box idpayment = Hive.box("idpaymentresep");

  @override
  void initState() {
    super.initState();
    if (idpayment.get('id') == null) {
      idpayment.put("id", "0");
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getonepatient();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getproblems();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getdaterepeat();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getdatesergery();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getdruge();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getpaymet();
    });
  }

  int num = 3;
  DateTime daterepeat = DateTime.now();
  void repeatdate() async {}

  DateTime datesurgery = DateTime.now();
  void surgerydate() async {}

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
                            val.dateenter = Jiffy.parse('${val.dateenter}').yMd;

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

                          Navigator.of(context)
                              .pushReplacementNamed('datapatient');
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

  Future<void> _addpayment() async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Consumer<changedata>(builder: (context, val, child) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Add payment'),
            elevation: 10,
            content: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: val.why,
                    decoration: InputDecoration(
                        label: Text('why'), prefixIcon: Icon(Icons.quiz_sharp)),
                  ),
                  TextFormField(
                    controller: val.payment,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'\d')),
                    ],
                    //initialValue: '01',
                    decoration: InputDecoration(
                        label: Text('pay'),
                        prefixIcon: Icon(Icons.attach_money_outlined)),
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
                        if (val.why.text != '' && val.payment.text != '') {
                          val.addpayment();
                          //val.sendpayment();
                          Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/newbody.jpg'), fit: BoxFit.cover)),
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
///////////////////////////////////////////////////////////////////////data patient
            Expanded(
              child:
                  //   SingleChildScrollView(
                  // child:
                  // Column(
                  //   children: [
                  Container(
                margin: EdgeInsets.only(left: 30, top: 30, bottom: 30),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(50)),
                child: Consumer<changedata>(builder: (context, val, child) {
                  return val.listonepatiebt.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 50, right: 50),
                                child: Column(
                                  children: [
                                    Text(
                                      "${val.listonepatiebt[0].name}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 80, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 20, right: 100),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Id: ${val.listonepatiebt[0].idpatient}",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white),
                                    ),
                                    Text(
                                      "Phone: ${val.listonepatiebt[0].phone}",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white),
                                    ),
                                    Text(
                                      "Age: ${val.listonepatiebt[0].age}",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white),
                                    ),
                                    Text(
                                      "Date: ${val.listonepatiebt[0].date}",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CircleAvatar(
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    printdatapatient(
                                                  name: val
                                                      .listonepatiebt[0].name,
                                                  id: val.listonepatiebt[0]
                                                      .idpatient,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.print)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                }),
              ),
            ),
/////////////////////////////////////////////////////////////////////salary pation
            Expanded(
                child: Consumer<changedata>(builder: (context, val, child) {
              return Container(
                  padding: EdgeInsets.only(left: 10, top: 30, bottom: 20),
                  child: ListView.builder(
                      itemCount: val.listpayment.length + 1,
                      itemBuilder: (context, i) {
                        return i < val.listpayment.length
                            ? Card(
                                color: Colors.black.withOpacity(0.5),
                                margin: EdgeInsets.all(10),
                                child: ListTile(
                                  // leading: IconButton(
                                  //     onPressed: () {
                                  //       List listcheck = [];
                                  //       for (int j = 0;
                                  //           j < val.mypayment.length;
                                  //           j++) {
                                  //         listcheck.add(val.mypayment.getAt(j));
                                  //         if (int.parse(
                                  //                     listcheck[j].idpayment) ==
                                  //                 int.parse(val.listpayment[i]
                                  //                     .idpayment) &&
                                  //             int.parse(val.listpayment[i]
                                  //                     .idpayment) >
                                  //                 int.parse(
                                  //                     idpayment.get('id'))) {
                                  //           val.mypayment.deleteAt(j);
                                  //           val.getpaymet();
                                  //         }
                                  //       }
                                  //     },
                                  //     icon: Icon(
                                  //       Icons.delete,
                                  //       color: Colors.white,
                                  //     )),
                                  title: Text(
                                    "${val.listpayment[i].why}",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    '${val.listpayment[i].date}',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  trailing: Text(
                                    '${val.listpayment[i].salary} \$',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                child: IconButton(
                                    onPressed: () {
                                      _addpayment();
                                    },
                                    icon: Icon(Icons.add)),
                              );
                      }));
            })),

////////////////////////////////////////////////////////icons
            Consumer<changedata>(builder: (context, val, child) {
              return Container(
                width: 80,
                height: 200,
                margin: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: () {
                              val.patienttodayscreen();
                              Navigator.of(context)
                                  .pushReplacementNamed('patienttoday');
                            },
                            icon: Icon(
                              Icons.co_present,
                              color: Colors.black,
                            ))),
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: () {
                            val.patientsscreen();
                            Navigator.of(context).pushReplacementNamed('home');
                          },
                          icon: Icon(
                            Icons.people,
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: () {
                            val.paymentscreen();
                            Navigator.of(context)
                                .pushReplacementNamed('paymentpage');
                          },
                          icon: Icon(
                            Icons.money,
                            color: Colors.black,
                          )),
                    )
                  ],
                ),
              );
            }),
          ],
        ),
      ),
      //////////////////////////////////////////////////////////////
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
                        onPressed: () async {
                          //await val.getpatientstoday_sendto();
                          await val.sendpayment();
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
}
