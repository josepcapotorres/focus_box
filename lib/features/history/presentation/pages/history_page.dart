import 'package:flutter/material.dart';

import '../../../../core/extensions/translations_extension.dart';
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
      appBar: AppBar(title: Text(context.l10n.historicalTitle)),
      body: Column(
        crossAxisAlignment: .start,
        spacing: 8,
        children: [
          const HistoryFilters(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: .start,
                spacing: 16,
                children: [
                  const HistorySelectedFilterDates(),
                  const HistoryMetrics(),
                  Text(
                    context.l10n.historicalDateRangeSummary,
                    style: textTheme.titleMedium,
                  ),
                  const SummaryChart(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
