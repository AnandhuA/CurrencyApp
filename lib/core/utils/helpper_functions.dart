import 'dart:convert';
import 'package:currency_rate_calculator/data/models/currency_model.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<List<Currency>> loadCurrencies() async {
  final String response = await rootBundle.loadString('assets/currencies/currencies.json');
  final List data = jsonDecode(response);
  return data.map((e) => Currency.fromJson(e)).toList();
}
