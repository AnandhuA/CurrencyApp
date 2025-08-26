
import 'package:currency_rate_calculator/models/currency_model.dart';
import 'package:currency_rate_calculator/models/responce_model.dart';
import 'package:hive_flutter/adapters.dart';

part 'currency_pair_model.g.dart';

@HiveType(typeId: 0)
class CurrencyPair {
  @HiveField(0)
  final Currency fromCurrency;
  @HiveField(1)
  final Currency toCurrency;

@HiveField(2)
  final ResponseModel result;




  CurrencyPair({
    required this.fromCurrency,
    required this.toCurrency,
    required this.result
  });
}
