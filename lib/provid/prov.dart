import 'dart:async';

import 'package:doctor/model/dbhive.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/rendering.dart';

import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';

import '../client/client.dart';

import 'package:http/http.dart' as http;

class changedata extends ChangeNotifier {
  late Box mypatient = Hive.box<patient>("patientresep");
  late Box myproblems = Hive.box<problems>("problemsresep");
  late Box myrepeat = Hive.box<repeat>("repeatresep");
  late Box mysurery = Hive.box<surgery>("sureryresep");
  late Box mydruges = Hive.box<druges>("drugesresep");
  late Box myhistory = Hive.box<history>("historyresep");
  late Box mypayment = Hive.box<salarys>("salarysresep");
  late Box idbox = Hive.box("idresep");
  late Box idpayment = Hive.box("idpaymentresep");

  late var lpatient;
  List listonepatiebt = [];
  List listproblem = [];
  List listrepeat = [];
  List listsurgery = [];
  List listdruges = [];
  List listhistory = [];
  List listpayment = [];
  List listpaymenttosend = [];
  List listpaymenttoday = [];

  List listcheck = [];
  List listpatientcheck = [];
  List listpatientrepeat = [];
  List listpatientsurgery = [];
  List listpatientstoday = [];
  List listpatientsearch = [];
  List listid = [];
  List listpatientstodaytosend = [];
  Map? datasend;
  late int idpatient;

  TextEditingController namef = new TextEditingController();
  TextEditingController phonef = new TextEditingController();
  TextEditingController agef = new TextEditingController();
  TextEditingController problem = new TextEditingController();
  TextEditingController druge = new TextEditingController();
  TextEditingController num = new TextEditingController();
  TextEditingController search = new TextEditingController();
  TextEditingController why = new TextEditingController();
  TextEditingController payment = new TextEditingController();

  String datef = Jiffy.now().yMd;
  late String daterepeat;
  String dateenter = '';
  late String datesurgery;

  int screen = 1;
  late int find;

  int show = 0;
  int monytoday = 0;

  patienttodayscreen() {
    screen = 1;
    notifyListeners();
  }

  repeatscreen() {
    screen = 2;
    notifyListeners();
  }

  surgeryscreen() {
    screen = 3;
    notifyListeners();
  }

  patientsscreen() {
    screen = 4;
    notifyListeners();
  }

  paymentscreen() {
    screen = 5;
    notifyListeners();
  }

  pationt_onlinescreen() {
    screen = 6;
    notifyListeners();
  }

  changeshow() {
    show = 1;
    notifyListeners();
  }

  changehide() {
    show = 0;
    notifyListeners();
  }

  addpatient() {
    if (dateenter == '') {
      mypatient.add(patient(
          name: namef.text,
          phone: phonef.text,
          age: agef.text,
          date: datef,
          idpatient: mypatient.length.toString()));
    } else {
      mypatient.add(patient(
          name: namef.text,
          phone: phonef.text,
          age: agef.text,
          date: dateenter,
          idpatient: mypatient.length.toString()));
    }

    namef.text = '';
    phonef.text = '';
    agef.text = '';
    dateenter = '';

    for (int i = 0; i < mypatient.length; i++) {
      displaypatient(i);
    }
    getidpatient(mypatient.length - 1);
    notifyListeners();
  }

  displaypatient(int id) {
    lpatient = mypatient.getAt(id);
  }

  getidpatient(int idp) {
    idpatient = idp;
    //print('from creet $idpatient');
    notifyListeners();
  }

  getonepatient() {
    listonepatiebt = [];
    listonepatiebt.add(mypatient.getAt(idpatient));
    //print(listonepatiebt[0].name);

    notifyListeners();
  }

  addproblems() {
    myproblems.put("${idpatient}",
        problems(idpatient: idpatient.toString(), problem: problem.text));
    problem.text = '';
    print('good');
    getproblems();
    notifyListeners();
  }

  getproblems() {
    listproblem = [];
    final patientProblem = myproblems.get("$idpatient");
    if (patientProblem != null) {
      listproblem.add(patientProblem);
      print('${listproblem[0].problem}');
    } else {
      // print('null');
    }
    notifyListeners();
  }

  adddaterepeat() {
    myrepeat.put("${idpatient}",
        repeat(idpatient: idpatient.toString(), date: daterepeat));

    //print('good date repeat');
    getdaterepeat();
    notifyListeners();
  }

  getdaterepeat() {
    listrepeat = [];
    final patientProblem = myrepeat.get("$idpatient");
    if (patientProblem != null) {
      listrepeat.add(patientProblem);
      print('${listrepeat[0].date}');
    } else {
      //print('null');
    }
    notifyListeners();
  }

  adddatesurgery() {
    mysurery.put("${idpatient}",
        surgery(idpatient: idpatient.toString(), date: datesurgery));

    //print('good date surgery');
    getdatesergery();
    notifyListeners();
  }

  getdatesergery() {
    listsurgery = [];
    final patientsurgery = mysurery.get("$idpatient");
    if (patientsurgery != null) {
      listsurgery.add(patientsurgery);
      //print('date surgery: ${listsurgery[0].date}');
    } else {
      print('null');
    }
    notifyListeners();
  }

  adddruge() {
    mydruges.add(druges(
        idpatient: idpatient.toString(),
        druge: druge.text,
        num: num.text,
        date: datef));

    druge.text = '';
    num.text = '';
    //print('good storage');

    getdruge();
    notifyListeners();
  }

  getdruge() {
    listcheck = [];
    listdruges = [];
    for (int i = 0; i < mydruges.length; i++) {
      final check = mydruges.getAt(i);

      if (check != null) {
        listcheck.add(check);
      }
    }

    for (int i = 0; i < listcheck.length; i++) {
      if (listcheck[i].idpatient == idpatient.toString()) {
        listdruges.add(listcheck[i]);
        //print('good surgery');
      }
    }
    // for (int i = 0; i < listdruges.length; i++) {
    //   print(listdruges[i].druge);
    // }

    notifyListeners();
  }

  getpatientrepeat() {
    listcheck = [];
    listpatientcheck = [];

    listpatientrepeat = [];

    for (int i = 0; i < myrepeat.length; i++) {
      final check = myrepeat.getAt(i);

      if (check != null) {
        listcheck.add(check);
      }
    }
    for (int i = 0; i < mypatient.length; i++) {
      final check = mypatient.getAt(i);

      if (check != null) {
        listpatientcheck.add(check);
      }
    }

    for (int i = 0; i < listcheck.length; i++) {
      if (listcheck[i].date == datef) {
        listpatientrepeat
            .add(listpatientcheck[int.parse(listcheck[i].idpatient)]);
        //listpatientrepeat=mypatient.getAt(int.parse(listcheck[i].idpatient));
        //print('good listpatient to day ${listpatientrepeat[i].name}');
      }
    }
    // for (int i = 0; i < listdruges.length; i++) {
    //   print(listdruges[i].druge);
    // }

    notifyListeners();
  }

  getpatientsurgery() {
    listcheck = [];
    listpatientcheck = [];

    listpatientsurgery = [];

    for (int i = 0; i < mysurery.length; i++) {
      final check = mysurery.getAt(i);

      if (check != null) {
        listcheck.add(check);
      }
    }
    for (int i = 0; i < mypatient.length; i++) {
      final check = mypatient.getAt(i);

      if (check != null) {
        listpatientcheck.add(check);
      }
    }

    for (int i = 0; i < listcheck.length; i++) {
      if (listcheck[i].date == datef) {
        listpatientsurgery
            .add(listpatientcheck[int.parse(listcheck[i].idpatient)]);
        //print('good listpatient surgery to day ${listpatientsurgery[0].name}');
      }
    }
    // for (int i = 0; i < listdruges.length; i++) {
    //   print(listdruges[i].druge);
    // }

    notifyListeners();
  }

  getpatientstoday() {
    listcheck = [];
    listpatientstoday = [];
    for (int i = 0; i < mypatient.length; i++) {
      final check = mypatient.getAt(i);

      if (check != null) {
        listcheck.add(check);
      }
    }

    for (int i = 0; i < listcheck.length; i++) {
      if (listcheck[i].date == datef) {
        listpatientstoday.add(listcheck[i]);
        //print('good patient today ${listpatientstoday[0].name}');
      }
    }
    // for (int i = 0; i < listdruges.length; i++) {
    //   print(listdruges[i].druge);
    // }

    notifyListeners();
  }

  getsearch() {
    listpatientsearch = [];
    int i = mypatient.length;
    if (!search.text.isEmpty) {
      try {
        i = int.parse(search.text);
      } catch (e) {
        print("error");
      }
    }

    if (i < mypatient.length && !search.text.isEmpty) {
      find = 1;
      listpatientsearch.add(mypatient.getAt(i));

      print(listpatientsearch[0].name);
    } else {
      find = 0;
    }
    search.text = '';

    notifyListeners();
  }

  ///client////////////////////////////////////////////////
  clie? clientmodel;
  List<String> logs = [];
  int port = 8080;
  Stream<NetworkAddress>? stream;
  NetworkAddress? address;
  int n = 0;

  StreamSubscription? _subscription;
  int test = 0;
  getIpAddress() async {
    test = 0;
    address = null;
    stream = NetworkAnalyzer.discover("192.168.1", port);
    //final ipAddress = InternetAddress('192.168.1.3');
    _subscription = stream!.listen((NetworkAddress networkAddress) {
      test += 1;
      if (networkAddress.exists) {
        address = networkAddress;
        clientmodel = clie(
            hostName: "${address!.ip}",
            onData: onData,
            onError: onError,
            port: port);
        test = 0;
        _subscription!.cancel();
      }
      //_subscription!.cancel();
      test >= 30 ? _subscription!.cancel() : null;
      updatetest(test);
      print(stream);
    });

    notifyListeners();
  }

  updatetest(int test1) {
    test = test1;
    notifyListeners();
  }

  void sendMessage(String message) {
    clientmodel!.write(message);
  }

  onData(Uint8List data) {
    final message = String.fromCharCodes(data);
    logs.add(message);
    print(message);
    //adddaterepeatandsurgery();
    //update = true;

    notifyListeners();
  }

  onError(dynamic error) {
    debugPrint("Error: $error");
  }

  // adddaterepeatandsurgery() {
  //   for (int i = 0; i < logs.length; i += 1) {
  //     final decodedBytes = base64.decode(logs[i]);
  //     final decodedString = utf8.decode(decodedBytes);
  //     Map data = jsonDecode(decodedString);
  //     myrepeat.put('${data['idpatient']}',
  //         repeat(idpatient: data['idpatient'], date: data['date']));
  //         getdaterepeat();
  //     notifyListeners();
  //   }
  // }

  //send data//////////////////////////////////////////////////////////////////
  getpatientstoday_sendto() async {
    //late int endid;
    listcheck = [];
    listpatientstodaytosend = [];
    for (int i = 0; i < mypatient.length; i++) {
      final check = await mypatient.getAt(i);

      if (check != null) {
        listcheck.add(check);
      }
    }

    for (int i = 0; i < listcheck.length; i++) {
      //print("${listcheck[i].idpatient}");
      if (int.parse(listcheck[i].idpatient) > int.parse(idbox.get('id')) ||
          int.parse(idbox.get('id')) == 0) {
        //int.parse(listcheck[i].idpatient)
        //&&int.parse(listcheck[i].idpatient)>int.parse(idbox.get('id'))
        //listcheck[i].date == datef&&اكواد مستخدمها ف if
        listpatientstodaytosend.add(listcheck[i]);
      }
    }
    if (!listpatientstodaytosend.isEmpty) {
      for (int i = 0; i < listpatientstodaytosend.length; i++) {
        //print("${listpatientstodaytosend[i].idpatient}");
        await clientmodel!.connect();
        if (clientmodel!.isConnected == true) {
          idbox.put("id", "${listpatientstodaytosend[i].idpatient}");
          datasend = {
            'type': 'patient',
            'name': listpatientstodaytosend[i].name,
            'phone': listpatientstodaytosend[i].phone,
            'age': listpatientstodaytosend[i].age,
            'date': listpatientstodaytosend[i].date,
            'idpatient': listpatientstodaytosend[i].idpatient,
          };

          //sendMessage(jsonEncode(datasend));
          final encodedString =
              await base64.encode(utf8.encode(jsonEncode(datasend)));
          sendMessage(encodedString);
          print(encodedString);
        }
      }
    }

    notifyListeners();
  }

  addpayment() {
    mypayment.add(salarys(
        idpatient: idpatient.toString(),
        salary: payment.text,
        why: why.text,
        date: datef,
        idpayment: (mypayment.length).toString()));
    payment.text = '';
    why.text = '';
    getpaymet();
    notifyListeners();
  }

  getpaymet() {
    listpayment = [];
    List listcheck = [];
    for (int i = 0; i < mypayment.length; i++) {
      listcheck.add(mypayment.getAt(i));
    }
    for (int i = 0; i < listcheck.length; i++) {
      if (int.parse(listcheck[i].idpatient) == idpatient) {
        listpayment.add(mypayment.getAt(i));
        print("id ${listpayment[0].why}");
      }
    }

    notifyListeners();
  }

  //send payment
  sendpayment() async {
    //late int endid;
    listcheck = [];
    listpaymenttosend = [];
    for (int i = 0; i < mypayment.length; i++) {
      final check = await mypayment.getAt(i);
      if (check != null) {
        listcheck.add(check);
      }
    }

    for (int i = 0; i < listcheck.length; i++) {
      if (int.parse(listcheck[i].idpayment) > int.parse(idpayment.get('id')) ||
          int.parse(idpayment.get('id')) == 0) {
        listpaymenttosend.add(listcheck[i]);
      }
    }
    if (!listpaymenttosend.isEmpty) {
      for (int i = 0; i < listpaymenttosend.length; i++) {
        await clientmodel!.connect();
        if (clientmodel!.isConnected == true) {
          // print(listpaymenttosend[i].name);
          datasend = {};
          idpayment.put("id", "${listpaymenttosend[i].idpayment}");
          datasend = {
            'type': 'payment',
            'why': listpaymenttosend[i].why,
            'salary': listpaymenttosend[i].salary,
            'date': listpaymenttosend[i].date,
            'idpatient': listpaymenttosend[i].idpatient,
          };

          //sendMessage(jsonEncode(datasend));
          final encodedString =
              await base64.encode(utf8.encode(jsonEncode(datasend)));
          sendMessage(encodedString);
          //print(encodedString);
        }
      }
    }

    notifyListeners();
  }

  getpaymettoday() {
    monytoday = 0;
    listpaymenttoday = [];
    List listcheck = [];
    for (int i = 0; i < mypayment.length; i++) {
      listcheck.add(mypayment.getAt(i));
    }
    for (int i = 0; i < listcheck.length; i++) {
      if (listcheck[i].date == datef) {
        listpaymenttoday.add(mypayment.getAt(i));

        print("id ${listpaymenttoday[0].why}");
      }
    }
    for (int i = 0; i < listpaymenttoday.length; i++) {
      monytoday = monytoday + int.parse(listpaymenttoday[i].salary);
    }

    notifyListeners();
  }

  /////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////\
  ////\/\/\/\/\/\/\/\//\/\/\/\/\/\/\/\/\/\/\/\//\/\/\\///\/\/\/\/\/\/\/\/\/
  String ip = 'localhost';
  //data doctor online in hive
  late Box iddoctorbox = Hive.box("idd");
  late Box f_namebox = Hive.box("f_named");
  late Box s_namebox = Hive.box("s_named");
  late Box phonebox = Hive.box("phoned");
  late Box passbox = Hive.box("passd");
  late Box agebox = Hive.box("aged");
  late Box descriptionbox = Hive.box("descriptiond");
  late Box specialtybox = Hive.box("specialtyd");
  late Box salarybox = Hive.box("salaryd");
  late Box emailbox = Hive.box("emaild");
  late Box citybox = Hive.box("cityd");
  late Box areabox = Hive.box("aread");
  late Box streatbox = Hive.box("streatd");
  late Box build_numbox = Hive.box("build_numd");
  late Box ratingbox = Hive.box("ratingd");
  int gender = 0;

  String day = '';
  List<String> weak = [
    "",
    "السبت",
    "الاحد",
    "الاتنين",
    "الثلاثاء",
    "الاربعاء",
    "الخميس",
    "الجمعه",
  ];

  List<String> specialtys = [
    "",
    "اسنان",
    "اطفال وحديثي الولاده",
    "جلدية",
    "مخ واعصاب",
    "عظام",
    "نساء وتوليد",
    "باطنة",
    "عيون",
    "كبد",
    "كلى",
    "انف وازن وحنجر",
    "جراحة تجميل",
    "قلب واوعية دمويه",
    "الآشعة التداخلية",
    "امراض الدم",
    "اورام",
    "تخسيس وتغذية",
    "نفسي",
    "جراحة اطفال",
    "جراحةأورام",
    "جراحة اوعية دموية",
    "جراحة سمنة ومناظر",
    "جراحة عامة",
    "جراحة عمود فقري",
    "جراحة قلب وصدر",
    "جراحة مخ واعصاب",
    "جهاز هضمي ومناظير",
    "حساسية ومناعة",
    "حقن مجهري واطفال انابيب",
    "ذكورة وعقم",
    "روماتيزم",
    "سكر وغدد صماء",
    "سمعيات",
    "صدر وجهاز تنفسي",
    "طب الاسرة",
    "طب المسنين",
    "طب تقويمي",
    "علاج الآلام",
    "علاج طبيعي واصابات ملاعب",
    "مراكز اشعه",
    "مسالك بوليه",
    "معامل تحاليل",
    "ممارسة عامة",
    "نطق وتخاطب"
  ];
  List<String> citys = [
    "",
    "القاهرة",
    "الجيزة",
    "الأسكندرية",
    "الدقهلية",
    "الشرقية",
    "المنوفية",
    "القليوبية",
    "البحيرة",
    "الغربية",
    "بور سعيد",
    "دمياط",
    "الإسماعلية",
    "السويس",
    "كفر الشيخ",
    "الفيوم",
    "بني سويف",
    "مطروح",
    "شمال سيناء",
    "جنوب سيناء",
    "المنيا",
    "أسيوط",
    "سوهاج",
    "قنا",
    "البحر الأحمر",
    "الأقصر",
    "أسوان",
    "الواحات",
    "الوادي الجديد"
  ];
  int indcity = 0;
  int indspecialty = 0;
  //page signup////////////////////////////////////////////////////
  TextEditingController f_name = new TextEditingController();
  TextEditingController s_name = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController salary = new TextEditingController();
  String specialtyt = '';
  String cityt = '';
  TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController pass1 = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController area = new TextEditingController();
  TextEditingController streat = new TextEditingController();
  TextEditingController build_num = new TextEditingController();
  String genderform = '';

  var datarigester = null;

  void registernew() async {
    datarigester = null;
    String url =
        "http://$ip/doctor/view/signupdoc.php?f_name=${f_name.text}&s_name=${s_name.text}&description=${description.text}&salary=${salary.text}&specialty=${specialtyt}&phone=${phone.text}&email=${email.text}&pass=${pass.text}&age=${age.text}&gender=${genderform}&city=${cityt}&area=${area.text}&streat=${streat.text}&build_num=${build_num.text}";

    try {
      var responseregister = await http.get(Uri.parse(url));
      if (!responseregister.body.isEmpty) {
        var responsebody = jsonDecode(responseregister.body);

        datarigester = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print(datarigester);
    print(datarigester);
    print(datarigester);
    notifyListeners();
  }

  //page signin///////////////////////////////////////////
  TextEditingController phonesignin = new TextEditingController();
  TextEditingController passsignin = new TextEditingController();

  //get account

  var data = null;
  void getdata() async {
    data = null;
    String url =
        "http://$ip/doctor/view/signindoc.php?phone=${phonesignin.text}&pass=${passsignin.text}";

    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);

        data = responsebody;
        iddoctorbox.put('id', '${data[0]['id']}');
        f_namebox.put('f_name', '${data[0]['f_name']}');
        print('${data[0]['f_name']}');
        print('${data[0]['f_name']}');
        print('${data[0]['f_name']}');
        s_namebox.put('s_name', '${data[0]['s_name']}');
        phonebox.put('phone', '${data[0]['phone']}');
        passbox.put('pass', '${data[0]['pass']}');
        agebox.put('age', '${data[0]['age']}');
        descriptionbox.put('description', '${data[0]['description']}');
        specialtybox.put('specialty', '${data[0]['specialty']}');
        salarybox.put('salary', '${data[0]['salary']}');
        emailbox.put('email', '${data[0]['email']}');
        citybox.put('city', '${data[0]['city']}');
        areabox.put('area', '${data[0]['area']}');
        streatbox.put('streat', '${data[0]['streat']}');
        build_numbox.put('build_num', '${data[0]['number_build']}');
        ratingbox.put('rating', '${data[0]['rating']}');
      }
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  void changecity(i) {
    indcity = i;
    cityt = citys[i];
    notifyListeners();
  }

  void changespecialty(i) {
    indspecialty = i;
    specialtyt = specialtys[i];
    notifyListeners();
  }

  void chosegender(String type) {
    if (type == 'male') {
      genderform = type;
      gender = 1;
    }
    if (type == 'fmale') {
      genderform = type;
      gender = 2;
    }
    notifyListeners();
  }

  //page profile logout
  logout() {
    iddoctorbox.put('id', '');
    f_namebox.put('f_name', '');
    s_namebox.put('s_name', '');
    phonebox.put('phone', '');
    passbox.put('pass', '');
    agebox.put('age', '');
    descriptionbox.put('description', '');
    specialtybox.put('specialty', '');
    salarybox.put('salary', '');
    emailbox.put('email', '');
    citybox.put('city', '');
    areabox.put('area', '');
    streatbox.put('streat', '');
    build_numbox.put('build_num', '');
    ratingbox.put('rating', '');
    notifyListeners();
  }

  //page profile data in page of pationt
  List reservation = [];

  void getpationtreservation() async {
    reservation = [];
    String url =
        "http://$ip/doctor/view/addpationt.php?id_doc=${iddoctorbox.get('id').toString()}";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        reservation = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print('${reservation}');
    addpatientonline();
    notifyListeners();
  }

  List numberpationttoday = [
    {'mes': 0}
  ];
  void getnumberpationttoday() async {
    numberpationttoday = [
      {'mes': 0}
    ];
    String url =
        "http://$ip/doctor/view/addpationt.php?id_doct=${iddoctorbox.get('id').toString()}";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        numberpationttoday = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print('number');
    print('${numberpationttoday}');

    notifyListeners();
  }

  addpatientonline() async {
    if (!reservation.isEmpty) {
      for (int i = 0; i < reservation.length; i++) {
        if (reservation[i]['send_to_doctor'] == 0) {
          String url =
              "http://$ip/doctor/view/addpationt.php?id_reser=${reservation[i]['id']}&update=update";
          try {
            var response = await http.get(Uri.parse(url));
            if (!response.body.isEmpty) {
              mypatient.add(patient(
                  name: reservation[i]['name_pationt'],
                  phone: reservation[i]['phone'],
                  age: reservation[i]['age'],
                  date: reservation[i]['date_enter'],
                  idpatient: mypatient.length.toString()));
            }
          } catch (e) {
            print(e);
          }
        }
      }
    }

    getidpatient(mypatient.length - 1);
    notifyListeners();
  }
}
