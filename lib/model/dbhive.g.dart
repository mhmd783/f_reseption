// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbhive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class patientAdapter extends TypeAdapter<patient> {
  @override
  final int typeId = 0;

  @override
  patient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return patient(
      name: fields[0] as String,
      phone: fields[1] as String,
      age: fields[2] as String,
      date: fields[3] as String,
      idpatient: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, patient obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.idpatient);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is patientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class problemsAdapter extends TypeAdapter<problems> {
  @override
  final int typeId = 1;

  @override
  problems read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return problems(
      idpatient: fields[0] as String,
      problem: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, problems obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.idpatient)
      ..writeByte(1)
      ..write(obj.problem);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is problemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class repeatAdapter extends TypeAdapter<repeat> {
  @override
  final int typeId = 2;

  @override
  repeat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return repeat(
      idpatient: fields[0] as String,
      date: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, repeat obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.idpatient)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is repeatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class surgeryAdapter extends TypeAdapter<surgery> {
  @override
  final int typeId = 3;

  @override
  surgery read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return surgery(
      idpatient: fields[0] as String,
      date: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, surgery obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.idpatient)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is surgeryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class drugesAdapter extends TypeAdapter<druges> {
  @override
  final int typeId = 4;

  @override
  druges read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return druges(
      idpatient: fields[0] as String,
      druge: fields[1] as String,
      num: fields[2] as String,
      date: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, druges obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.idpatient)
      ..writeByte(1)
      ..write(obj.druge)
      ..writeByte(2)
      ..write(obj.num)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is drugesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class historyAdapter extends TypeAdapter<history> {
  @override
  final int typeId = 5;

  @override
  history read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return history(
      idpatient: fields[0] as String,
      problem: fields[1] as String,
      date: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, history obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.idpatient)
      ..writeByte(1)
      ..write(obj.problem)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is historyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class salarysAdapter extends TypeAdapter<salarys> {
  @override
  final int typeId = 6;

  @override
  salarys read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return salarys(
      idpatient: fields[0] as String,
      salary: fields[1] as String,
      why: fields[2] as String,
      date: fields[3] as String,
      idpayment: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, salarys obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.idpatient)
      ..writeByte(1)
      ..write(obj.salary)
      ..writeByte(2)
      ..write(obj.why)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.idpayment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is salarysAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
