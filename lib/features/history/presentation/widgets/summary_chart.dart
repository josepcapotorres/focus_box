import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/enums/task_status.dart';
import '../../../../core/extensions/double_extension.dart';
import '../../../../core/extensions/task_status_localization_extension.dart';
import '../../../../core/extensions/translations_extension.dart';
import '../../../task_details/domain/entities/task_history_entry.dart';
import '../providers/history_metrics_provider.dart';

class SummaryChart extends ConsumerWidget {
  const SummaryChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref
        .watch(historyEntriesBetweenSelectedDateRangeProvider)
        .value;
    final summary = _calculateWorkedDistributionByStatus(entries);

    if (summary.isEmpty) {
      return Expanded(
        child: Center(child: Text(context.l10n.historicalSummaryNoRecordsYet)),
      );
    }

    return SizedBox(
      height: 200,
      child: Row(
        spacing: 24,
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sections: summary.entries
                    .map(
                      (e) => PieChartSectionData(
                        value: e.value,
                        color: e.key.foregroundColor,
                        showTitle: false,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: Column(
              spacing: 16,
              children: summary.entries
                  .map(
                    (e) => Row(
                      spacing: 8,
                      children: [
                        SizedBox.square(
                          dimension: 20,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: e.key.foregroundColor,
                            ),
                          ),
                        ),
                        Text(e.key.label(context.l10n)),
                        Text("${e.value.formatDouble()} %"),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Map<TaskStatus, double> _calculateWorkedDistributionByStatus(
    List<TaskHistoryEntry>? tasks,
  ) {
    if (tasks == null) return {};

    final workedByStatus = <TaskStatus, Duration>{};

    for (final entry in tasks) {
      workedByStatus[entry.toStatus] =
          (workedByStatus[entry.toStatus] ?? Duration.zero) +
          entry.timestamp.timeZoneOffset;
    }

    final totalWorked = workedByStatus.values.fold(
      Duration.zero,
      (a, b) => a + b,
    );

    if (totalWorked == Duration.zero) {
      return {};
    }

    final totalMs = totalWorked.inMilliseconds;

    return workedByStatus.map(
      (status, worked) =>
          MapEntry(status, worked.inMilliseconds / totalMs * 100),
    );
  }
}
