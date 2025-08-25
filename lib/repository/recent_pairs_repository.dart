import 'package:currency_rate_calculator/models/currency_pair_model.dart';
import 'package:hive_flutter/adapters.dart';

class RecentPairsRepository {
  final Box<CurrencyPair> _box = Hive.box<CurrencyPair>('recent_pairs');

  /// Add a new pair with flag & code
  Future<void> addRecentPair({
    required String fromCode,
    required String fromFlag,
    required String toCode,
    required String toFlag,
  }) async {
    final pair = CurrencyPair(
      fromCode: fromCode,
      fromFlag: fromFlag,
      toCode: toCode,
      toFlag: toFlag,
    );

    // Prevent duplicate entries
    final exists = _box.values.any((p) =>
        p.fromCode == fromCode &&
        p.toCode == toCode &&
        p.fromFlag == fromFlag &&
        p.toFlag == toFlag);

    if (!exists) {
      await _box.add(pair);
    }
  }

  /// Get all saved pairs
  List<CurrencyPair> getRecentPairs() {
    return _box.values.toList().reversed.toList(); // latest first
  }

  /// Optional: Clear all
  Future<void> clearRecentPairs() async {
    await _box.clear();
  }
}
