class TrendPoint {
  final DateTime date;
  final double value;
  TrendPoint(this.date, this.value);
}

// Mock generator (last 5 days)
List<TrendPoint> getMockTrendData() {
  final now = DateTime.now();
  return List.generate(5, (i) {
    return TrendPoint(
      now.subtract(Duration(days: 4 - i)),
      (80 + i * 2 + (i % 2 == 0 ? 3 : -2)).toDouble(), // mock values
    );
  });
}
