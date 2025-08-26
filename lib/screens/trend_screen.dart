import 'dart:math';

import 'package:currency_rate_calculator/models/trend_point_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TrendScreen extends StatelessWidget {
  final String from;
  final String to;

  const TrendScreen({super.key, required this.from, required this.to});

  @override
  Widget build(BuildContext context) {
    final data = getMockTrendData();
    final minVal = data.map((e) => e.value).reduce(min);
    final maxVal = data.map((e) => e.value).reduce(max);
    final avgVal =
        data.map((e) => e.value).reduce((a, b) => a + b) / data.length;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: LineChart(
                LineChartData(
                  minY: minVal - 5,
                  maxY: maxVal + 5,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= data.length) {
                            return const SizedBox.shrink();
                          }
                          return Text(
                            "${data[index].date.day}/${data[index].date.month}",
                            style: const TextStyle(fontSize: 12),
                          );
                        },
                      ),
                    ),
                  ),
                  lineTouchData: LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (spots) {
                        return spots.map((spot) {
                          final dp = data[spot.x.toInt()];
                          return LineTooltipItem(
                            "${dp.date.day}/${dp.date.month}\n${dp.value.toStringAsFixed(2)}",
                            const TextStyle(color: Colors.white),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: Colors.blue,
                      spots: [
                        for (int i = 0; i < data.length; i++)
                          FlSpot(i.toDouble(), data[i].value),
                      ],
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
                duration: const Duration(milliseconds: 800), // animated draw
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _Chip("Min: ${minVal.toStringAsFixed(2)}"),
                _Chip("Avg: ${avgVal.toStringAsFixed(2)}"),
                _Chip("Max: ${maxVal.toStringAsFixed(2)}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  const _Chip(this.label);

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label), backgroundColor: Colors.blue.shade50);
  }
}
