// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responce_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResponseModelAdapter extends TypeAdapter<ResponseModel> {
  @override
  final int typeId = 2;

  @override
  ResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResponseModel(
      base: fields[0] as String,
      amount: fields[1] as String,
      result: fields[2] as double,
      rate: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ResponseModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.base)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.result)
      ..writeByte(3)
      ..write(obj.rate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
