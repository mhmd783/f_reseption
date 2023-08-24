import 'package:hive/hive.dart';
part 'dbhive.g.dart';

@HiveType(typeId: 0)
class patient extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String phone;

  @HiveField(2)
  late String age;

  @HiveField(3)
  late String date;
  @HiveField(4)
  late String idpatient;

  patient(
      {required this.name,
      required this.phone,
      required this.age,
      required this.date,
      required this.idpatient});
}

@HiveType(typeId: 1)
class problems extends HiveObject {
  @HiveField(0)
  late String idpatient;

  @HiveField(1)
  late String problem;

  problems({required this.idpatient, required this.problem});
}

@HiveType(typeId: 2)
class repeat extends HiveObject {
  @HiveField(0)
  late String idpatient;

  @HiveField(1)
  late String date;

  repeat({required this.idpatient, required this.date});
}

@HiveType(typeId: 3)
class surgery extends HiveObject {
  @HiveField(0)
  late String idpatient;

  @HiveField(1)
  late String date;

  surgery({required this.idpatient, required this.date});
}

@HiveType(typeId: 4)
class druges extends HiveObject {
  @HiveField(0)
  late String idpatient;

  @HiveField(1)
  late String druge;

  @HiveField(2)
  late String num;

  @HiveField(3)
  late String date;
  druges(
      {required this.idpatient,
      required this.druge,
      required this.num,
      required this.date});
}


@HiveType(typeId: 5)
class history extends HiveObject {
  @HiveField(0)
  late String idpatient;

  @HiveField(1)
  late String problem;

  @HiveField(2)
  late String date;
  history(
      {required this.idpatient,
      required this.problem,
      required this.date});
}

@HiveType(typeId: 6)
class salarys extends HiveObject {
  @HiveField(0)
  late String idpatient;

  @HiveField(1)
  late String salary;

  @HiveField(2)
  late String why;

  @HiveField(3)
  late String date;

  @HiveField(4)
  late String idpayment;
  salarys(
      {required this.idpatient,
      required this.salary,
      required this.why,
      required this.date,
      required this.idpayment});
}