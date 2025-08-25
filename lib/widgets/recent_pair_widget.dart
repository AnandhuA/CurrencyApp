import 'package:currency_rate_calculator/models/currency_pair_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RecentPairsWidget extends StatelessWidget {
  const RecentPairsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox<CurrencyPair>('recent_pairs'),
      builder: (context, AsyncSnapshot<Box<CurrencyPair>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text("No recent pairs yet.");
        }

        final box = snapshot.data!;
        final pairs = box.values.toList().reversed.toList(); // latest first

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recent Pairs",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: pairs.map((pair) {
                return _ChipWidget(
                  "${pair.fromFlag} ${pair.fromCode} → ${pair.toFlag} ${pair.toCode}",
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

class _ChipWidget extends StatelessWidget {
  final String label;
  const _ChipWidget(this.label);

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label), backgroundColor: Colors.blue.shade50);
  }
}
