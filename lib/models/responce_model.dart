import 'package:hive_flutter/adapters.dart';

part 'responce_model.g.dart';

@HiveType(typeId: 2)
class ResponseModel {
  @HiveField(0)
  final String base;
  @HiveField(1)
  final String amount;
  @HiveField(2)
  final double result;
  @HiveField(3)
  final double rate;

  ResponseModel({
    required this.base,
    required this.amount,
    required this.result,
    required this.rate,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      base: json['base'] as String,
      amount: json['amount'] as String,
      result: (json['result']?['AUD'] ?? 0.0).toDouble(),
      rate: (json['result']?['rate'] ?? 0.0).toDouble(),
    );
  }
}
