import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:doctor/provid/prov.dart';
import 'package:flutter/services.dart';

class pationt_online extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _pationt_online();
  }
}

class _pationt_online extends State<pationt_online> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getpationtreservation();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getnumberpationttoday();
    });
  }

  late Box iddoctorbox = Hive.box("idd");
  late Box f_namebox = Hive.box("f_named");
  late Box s_namebox = Hive.box("s_named");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 246, 236, 150),
        actions: [
          iddoctorbox.get('id') == null || iddoctorbox.get('id') == ''
              ? TextButton(
                  onPressed: () {
                    _signin();
                  },
                  child: Text(
                    'تسجيل الدخول',
                    style: TextStyle(color: Colors.black),
                  ))
              : Container(),
          iddoctorbox.get('id') == null || iddoctorbox.get('id') == ''
              ? TextButton(
                  onPressed: () {
                    _signup();
                  },
                  child: Text(
                    'تسجيل حساب جديد',
                    style: TextStyle(color: Colors.black),
                  ))
              : Container(),
          iddoctorbox.get('id') == null || iddoctorbox.get('id') == ''
              ? Container()
              : TextButton(
                  onPressed: () {
                    checklogout();
                  },
                  child: Text(
                    'تسجيل الخروج',
                    style: TextStyle(color: Colors.black),
                  ))
        ],
        leading: iddoctorbox.get('id') == null && iddoctorbox.get('id') == ''
            ? Container()
            : IconButton(
                onPressed: () {},
                icon: CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                )),
        title: iddoctorbox.get('id') == null || iddoctorbox.get('id') == ''
            ? Container()
            : Text(
                'د:${f_namebox.get('f_name')} ${s_namebox.get('s_name')}',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
      ),
      body: Row(
        children: [
          ////desplay data//////////////////////////////////////////////////////////////////
          Expanded(
            flex: 7,
            child: Container(
              child: Consumer<changedata>(builder: (context, val, child) {
                return !val.reservation.isEmpty &&
                            iddoctorbox.get('id') != null ||
                        iddoctorbox.get('id') != ''
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        itemCount: val.reservation.length,
                        itemBuilder: (context, i) {
                          return Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.all(30),
                            height: 250,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: MaterialButton(
                              //button person

                              onPressed: () {},
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
                                        '${val.reservation[i]['name_pationt']}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${val.reservation[i]['phone']}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${val.reservation[i]['date_enter']}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                    : Center(
                        child: Center(
                            child: Text(
                          'لا يوجد بيانات لعرضها ',
                          style: TextStyle(fontSize: 25, color: Colors.grey),
                        )),
                      );
              }),
            ),
          ),
          ////////////////////////////////////////////////////////////////////////////////
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

                  ///pages/////////////////////////////////////////////////////////
                  ///
                  ///

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
                          trailing: Text('${val.numberpationttoday[0]['mes']}'),
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
      floatingActionButton:
          iddoctorbox.get('id') == null || iddoctorbox.get('id') == ''
              ? Container()
              : Consumer<changedata>(builder: (context, val, child) {
                  return FloatingActionButton(
                    backgroundColor: Colors.white,
                    elevation: 20,
                    onPressed: () {
                      val.getpationtreservation();
                      val.getnumberpationttoday();
                    },
                    child: Icon(
                      Icons.download,
                      color: Colors.black,
                    ),
                  );
                }),
    );
  }

  //signup /////////////////////////////////////////////////////
  Future<void> _signup() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('signup'),
          elevation: 10,
          content: Form(
            child: Consumer<changedata>(builder: (context, val, child) {
              return Center(
                child: Form(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Text("Doctor Signup", style: TextStyle(fontSize: 30)),
                        TextFormField(
                          controller: val.f_name,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            label: Text("اسمك"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: val.s_name,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            label: Text("اسم الاب"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: val.description,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            label: Text("وصف ليك"),
                          ),
                        ),
                        TextFormField(
                          controller: val.salary,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: Text("سعر الكشف"),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'\d')),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            'اختار التخصص',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 300,
                          height: 40,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: val.specialtys.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: val.indspecialty == i
                                          ? Colors.grey
                                          : const Color.fromARGB(
                                              255, 243, 243, 58),
                                      borderRadius: BorderRadius.circular(50)),
                                  margin: EdgeInsets.only(left: 10),
                                  child: TextButton(
                                      onPressed: () {
                                        val.changespecialty(i);
                                      },
                                      child: Text(
                                        '${val.specialtys[i]}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: val.phone,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            label: Text("رقم تلفونك"),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'\d')),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: val.email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            label: Text("ايميلك"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: val.pass,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            label: Text("كلمه السر"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text("تكرار كلمه السر"),
                          ),
                          controller: val.pass1,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          width: 12,
                          height: 20,
                        ),
                        TextFormField(
                          controller: val.age,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: Text("عمرك"),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'\d')),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            'اختار المدينه',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 300,
                          height: 40,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: val.citys.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: val.indcity == i
                                          ? Colors.grey
                                          : const Color.fromARGB(
                                              255, 243, 243, 58),
                                      borderRadius: BorderRadius.circular(50)),
                                  margin: EdgeInsets.only(left: 10),
                                  child: TextButton(
                                      onPressed: () {
                                        val.changecity(i);
                                      },
                                      child: Text(
                                        '${val.citys[i]}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: val.area,
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                            label: Text("المنطقه"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: val.streat,
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                            label: Text("الشارع"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: val.build_num,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: Text("رقم العماره "),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'\d')),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: CircleAvatar(
                              radius: 25,
                              backgroundColor: val.gender == 1
                                  ? const Color.fromARGB(255, 243, 243, 58)
                                  : Colors.white,
                              child: IconButton(
                                icon: Icon(
                                  Icons.male,
                                  size: 30,
                                ),
                                onPressed: () {
                                  val.chosegender('male');
                                },
                              ),
                            )),
                            Expanded(
                                child: CircleAvatar(
                              radius: 25,
                              backgroundColor: val.gender == 2
                                  ? const Color.fromARGB(255, 243, 243, 58)
                                  : Colors.white,
                              child: IconButton(
                                icon: Icon(
                                  Icons.female,
                                  size: 30,
                                ),
                                onPressed: () {
                                  val.chosegender('fmale');
                                },
                              ),
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            if (val.f_name.text != '' &&
                                val.s_name.text != '' &&
                                val.description.text != '' &&
                                val.salary.text != '' &&
                                val.specialtyt != '' &&
                                val.cityt != '' &&
                                val.phone.text.length > 10 &&
                                val.email.text != '' &&
                                val.age.text != '' &&
                                val.pass.text == val.pass1.text &&
                                val.area.text != '' &&
                                val.streat.text != '' &&
                                val.build_num.text != '' &&
                                val.genderform != '') {
                              val.registernew();

                              _check();
                            } else {
                              _message();
                            }
                          },
                          child: Text(
                            "تسجيل",
                            style: TextStyle(fontSize: 17),
                          ),
                          color: Colors.white30,
                          padding:
                              EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Future<void> _check() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('تحقق'),
          elevation: 10,
          content: Form(
            child: Consumer<changedata>(builder: (context, val, child) {
              return Center(
                child: val.datarigester == null
                    ? Center(child: CircularProgressIndicator())
                    : val.datarigester[0]['mes'] == 'not'
                        ? Center(child: Text('هذا الرقم مسجل'))
                        : Center(child: Text('تم تسجيل الحساب بنجاح!')),
              );
            }),
          ),
          actions: <Widget>[
            Consumer<changedata>(builder: (context, val, child) {
              return val.datarigester != null &&
                      val.datarigester[0]['mes'] != 'not'
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(50)),
                      child: MaterialButton(
                        child: Text("تسجل الدخول"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushReplacementNamed("pationt_online");
                        },
                      ),
                    )
                  : Container();
            }),
          ],
        );
      },
    );
  }

  Future<void> _message() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Icon(
            Icons.error,
            color: Colors.redAccent,
          ),
          elevation: 10,
          content: Form(
            child: Center(child: Text('هناك خطاء في البيانات !!!')),
          ),
        );
      },
    );
  }

  Future<void> _signin() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('signin'),
          elevation: 10,
          content: Consumer<changedata>(builder: (context, val, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Text("Doctor Login", style: TextStyle(fontSize: 30)),
                  TextFormField(
                    controller: val.phonesignin,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      label: Text("رقم التلفون"),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'\d')),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: val.passsignin,
                    obscureText: true,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      label: Text("كلمه السر"),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      val.getdata();

                      _checksignin();
                    },
                    child: Text(
                      "دخول",
                      style: TextStyle(fontSize: 17),
                    ),
                    color: Colors.white30,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  Future<void> _checksignin() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('تحقق'),
          elevation: 10,
          content: Form(
            child: Consumer<changedata>(builder: (context, val, child) {
              return Center(
                child: val.data == null
                    ? Center(child: CircularProgressIndicator())
                    : val.data[0]['mes'] == 'not'
                        ? Center(child: Text('لا يوجد الحساب!'))
                        : Center(child: Text('مرحبا بك !')),
              );
            }),
          ),
          actions: <Widget>[
            Consumer<changedata>(builder: (context, val, child) {
              return val.data != null && val.data[0]['mes'] != 'not'
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(50)),
                      child: MaterialButton(
                        child: Text("دخول"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushReplacementNamed("pationt_online");
                        },
                      ),
                    )
                  : Container();
            }),
          ],
        );
      },
    );
  }

  checklogout() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('تاكيد تسجيل الخروج'),
          elevation: 10,
          content: Form(
            child: Consumer<changedata>(builder: (context, val, child) {
              return Column(
                children: [
                  Text(
                    "هل انت متاكد من تسجل الخروج؟؟",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  //Icon(Icons.logout),
                ],
              );
            }),
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Consumer<changedata>(builder: (context, val, child) {
                    return IconButton(
                        onPressed: () {
                          val.logout();
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushReplacementNamed("pationt_online");
                        },
                        icon: Icon(
                          Icons.offline_pin_outlined,
                          color: Colors.greenAccent,
                          size: 30,
                        ));
                  }),
                ),
                Expanded(
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        //Navigator.of(context).pushNamed('routeName');
                      },
                      icon: Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.black,
                        size: 30,
                      )),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
