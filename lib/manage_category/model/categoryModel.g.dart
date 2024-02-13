// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryModelAdapter extends TypeAdapter<CategoryModel> {
  @override
  final int typeId = 3;

  @override
  CategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryModel(
      id: fields[0] as String,
      parentName: fields[1] as String,
      name: fields[2] as String,
      orderNum: fields[3] as int,
      creatorEmail: fields[4] as String,
      attachUrl: fields[5] as String,
      productCount: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.parentName)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.orderNum)
      ..writeByte(4)
      ..write(obj.creatorEmail)
      ..writeByte(5)
      ..write(obj.attachUrl)
      ..writeByte(6)
      ..write(obj.productCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
