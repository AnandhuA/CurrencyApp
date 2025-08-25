
import 'package:hive_flutter/adapters.dart';

part 'currency_pair_model.g.dart';

@HiveType(typeId: 0)
class CurrencyPair {
  @HiveField(0)
  final String fromCode;

  @HiveField(1)
  final String fromFlag;

  @HiveField(2)
  final String toCode;

  @HiveField(3)
  final String toFlag;

  CurrencyPair({
    required this.fromCode,
    required this.fromFlag,
    required this.toCode,
    required this.toFlag,
  });
}
