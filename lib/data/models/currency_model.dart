import 'package:hive_flutter/adapters.dart';
part 'currency_model.g.dart';

@HiveType(typeId: 1)
class Currency {
    @HiveField(0)
  final String code;
    @HiveField(1)
  final String name;
    @HiveField(2)
  final String flag;

  Currency({required this.code, required this.name, required this.flag});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(code: json['code'], name: json['name'], flag: json['flag']);
  }
}
