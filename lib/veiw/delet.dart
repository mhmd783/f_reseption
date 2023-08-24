import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/dbhive.dart';

class delet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _delet();
  }
}

class _delet extends State<delet> {
  late Box mypatient = Hive.box<patient>("patientresep");
  late Box myproblems = Hive.box<problems>("problemsresep");
  late Box myrepeat = Hive.box<repeat>("repeatresep");
  late Box mysurery = Hive.box<surgery>("sureryresep");
  late Box mydruges = Hive.box<druges>("drugesresep");
  late Box myhistory = Hive.box<history>("historyresep");
  late Box mypayment = Hive.box<salarys>("salarysresep");
  late Box idbox = Hive.box('idresep');
  late Box idpayment = Hive.box("idpaymentresep");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: IconButton(
              onPressed: () {
                mypatient.deleteFromDisk();
                myproblems.deleteFromDisk();
                myrepeat.deleteFromDisk();
                mysurery.deleteFromDisk();
                mydruges.deleteFromDisk();
                myhistory.deleteFromDisk();
                mypayment.deleteFromDisk();
                idbox.delete('id');
                idpayment.delete('id');
              },
              icon: Icon(Icons.delete))),
    );
  }
}
