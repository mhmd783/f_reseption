import 'dart:io';
import 'package:doctor/provid/prov.dart';
import 'package:doctor/veiw/datapatient.dart';
import 'package:doctor/veiw/delet.dart';
import 'package:doctor/veiw/home.dart';
import 'package:doctor/veiw/patienttoday.dart';
import 'package:doctor/veiw/pationt_online.dart';
import 'package:doctor/veiw/payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'model/dbhive.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  //adapter
  Hive.registerAdapter(patientAdapter());
  Hive.registerAdapter(problemsAdapter());
  Hive.registerAdapter(repeatAdapter());
  Hive.registerAdapter(surgeryAdapter());
  Hive.registerAdapter(drugesAdapter());
  Hive.registerAdapter(historyAdapter());
  Hive.registerAdapter(salarysAdapter());
  //openboxes
  await Hive.openBox<patient>("patientresep");
  await Hive.openBox<problems>("problemsresep");
  await Hive.openBox<repeat>("repeatresep");
  await Hive.openBox<surgery>("sureryresep");
  await Hive.openBox<druges>("drugesresep");
  await Hive.openBox<history>("historyresep");

  await Hive.openBox<salarys>("salarysresep");

  await Hive.openBox("idresep");
  await Hive.openBox("idpaymentresep");

  //data doctor online
  await Hive.initFlutter(dir.path);
  await Hive.openBox('idd');
  await Hive.openBox('f_named');
  await Hive.openBox('s_named');
  await Hive.openBox('phoned');
  await Hive.openBox('passd');
  await Hive.openBox('aged');
  await Hive.openBox('descriptiond');
  await Hive.openBox('specialtyd');
  await Hive.openBox('salaryd');
  await Hive.openBox('emaild');
  await Hive.openBox('cityd');
  await Hive.openBox('aread');
  await Hive.openBox('streatd');
  await Hive.openBox('build_numd');
  await Hive.openBox('ratingd');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return changedata();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          'home': (context) => home(),
          'datapatient': (context) => datapationt(),
          'patienttoday':(context) => patienttoday(),
          'paymentpage':(context) => paymentpage(),
          'pationt_online':(context) => pationt_online(),
          
          //'print':(context) => print(name: '', id: '', date: '', redate: '', sudate: '', druge: []),

        },
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home:  patienttoday(),
      ),
    );
  }
}
