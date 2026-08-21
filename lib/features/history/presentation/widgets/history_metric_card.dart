import 'package:flutter/material.dart';

class HistoryMetricCard extends StatelessWidget {
  final String label;
  final String metricValue;
  final Color backgroundColor;
  final Color labelColor;
  final Color metricColor;

  const HistoryMetricCard({
    super.key,
    required this.label,
    required this.metricValue,
    required this.backgroundColor,
    required this.labelColor,
    required this.metricColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return SizedBox(
      height: 100,
      child: Card(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: textTheme.labelLarge?.copyWith(color: labelColor),
                ),
              ),
              Text(
                metricValue,
                style: textTheme.headlineMedium?.copyWith(color: metricColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
