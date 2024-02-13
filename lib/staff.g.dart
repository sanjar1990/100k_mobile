// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StaffAdapter extends TypeAdapter<Staff> {
  @override
  final int typeId = 2;

  @override
  Staff read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Staff(
      name: fields[0] as String,
      email: fields[1] as String,
      phone: fields[2] as String,
      birthDate: fields[3] as DateTime,
      attachUrl: fields[4] as String,
      role: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Staff obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.birthDate)
      ..writeByte(4)
      ..write(obj.attachUrl)
      ..writeByte(5)
      ..write(obj.role);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StaffAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
