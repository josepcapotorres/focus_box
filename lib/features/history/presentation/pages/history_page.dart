import 'package:flutter/material.dart';

import '../widgets/history_filters.dart';
import '../widgets/history_metrics.dart';
import '../widgets/history_selected_filter_dates.dart';
import '../widgets/summary_chart.dart';

class HistoryPage extends StatelessWidget {
  static const routeName = "/history";

  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Historial")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: .start,
          spacing: 16,
          children: [
            const HistoryFilters(),
            const HistorySelectedFilterDates(),
            const HistoryMetrics(),
            Text("Resumen del día", style: textTheme.headlineSmall),
            const SummaryChart(),
          ],
        ),
      ),
    );
  }
}
