// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_pair_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyPairAdapter extends TypeAdapter<CurrencyPair> {
  @override
  final int typeId = 0;

  @override
  CurrencyPair read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyPair(
      fromCode: fields[0] as String,
      fromFlag: fields[1] as String,
      toCode: fields[2] as String,
      toFlag: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyPair obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.fromCode)
      ..writeByte(1)
      ..write(obj.fromFlag)
      ..writeByte(2)
      ..write(obj.toCode)
      ..writeByte(3)
      ..write(obj.toFlag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyPairAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
