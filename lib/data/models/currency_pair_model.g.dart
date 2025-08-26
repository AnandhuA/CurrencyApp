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
      fromCurrency: fields[0] as Currency,
      toCurrency: fields[1] as Currency,
      result: fields[2] as ResponseModel,
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyPair obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.fromCurrency)
      ..writeByte(1)
      ..write(obj.toCurrency)
      ..writeByte(2)
      ..write(obj.result);
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
