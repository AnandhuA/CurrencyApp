import 'package:currency_rate_calculator/data/models/currency_model.dart';
import 'package:currency_rate_calculator/data/models/currency_pair_model.dart';
import 'package:currency_rate_calculator/data/models/responce_model.dart';
import 'package:hive_flutter/adapters.dart';

class RecentPairsRepository {
  final Box<CurrencyPair> _box = Hive.box<CurrencyPair>('recent_pairs');

  /// Add a new pair with flag & code
  Future<void> addRecentPair({
    required Currency fromCurrency,
    required Currency toCurrency,
    required ResponseModel result
  }) async {
    final pair = CurrencyPair(
      fromCurrency: fromCurrency,
      toCurrency: toCurrency,
      result: result,
     
    );

    final exists = _box.values.any((p) =>
        p.fromCurrency == fromCurrency && p.toCurrency == toCurrency,
    );

    if (!exists) {
      await _box.add(pair);
    }
  }

  List<CurrencyPair> getRecentPairs() {
    return _box.values.toList().reversed.toList(); 
  }

  Future<void> clearRecentPairs() async {
    await _box.clear();
  }
}
