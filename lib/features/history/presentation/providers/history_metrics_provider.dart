import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/domain/entities/task.dart';
import '../../../../core/extensions/datetime_extension.dart';
import '../../../../core/managers/crash_reporter.dart';
import '../../../home/presentation/providers/home_tasks_provider.dart';
import '../../../task_details/domain/entities/task_history_entry.dart';
import '../../../task_details/presentation/providers/task_details_history_provider.dart';
import '../../domain/entities/history_metric.dart';
import 'history_date_ranges_filter_provider.dart';

part 'history_metrics_provider.g.dart';

@riverpod
Future<HistoryMetric> historyMetrics(Ref ref) async {
  final tasks = await ref.watch(
    historyTasksBetweenSelectedDateRangeProvider.future,
  );

  final entries = await ref.watch(
    historyEntriesBetweenSelectedDateRangeProvider.future,
  );

  final realTimeDevoted = _calculateRealTimeDevoted(entries);

  final expectedTime = tasks.fold(
    Duration.zero,
    (total, task) => total + task.timeTotal,
  );

  ref.read(crashReporterProvider)
    ..log("historyMetricsProvider")
    ..setCustomKey("expectedTime_millis", expectedTime.inMilliseconds)
    ..setCustomKey("real_time_devoted_millis", realTimeDevoted.inMilliseconds);

  final focusRatioPercentage = expectedTime.inMilliseconds == 0
      ? 0
      : (realTimeDevoted.inMilliseconds / expectedTime.inMilliseconds * 100)
            .floor();

  return HistoryMetric(realTimeDevoted, expectedTime, focusRatioPercentage);
}

Duration _calculateRealTimeDevoted(List<TaskHistoryEntry> entries) {
  if (entries.length < 2) return Duration.zero;

  final sortedEntries = [...entries]
    ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

  Duration total = Duration.zero;

  for (int i = 1; i < sortedEntries.length; i++) {
    final previous = sortedEntries[i - 1];
    final current = sortedEntries[i];

    if (previous.toStatus == .inProgress) {
      total += current.timestamp.difference(previous.timestamp);
    }
  }

  return total;
}

@riverpod
Future<List<Task>> historyTasksBetweenSelectedDateRange(Ref ref) async {
  final tasks = ref.watch(homeTasksProvider).value ?? [];
  final (from, to) = ref.watch(historyRateRangesFilterProvider);

  final crashProvider = ref.read(crashReporterProvider)
    ..log("historyTasksBetweenSelectedDateRangeProvider")
    ..setCustomKey("from", from.toIso8601String())
    ..setCustomKey("to", to.toIso8601String())
    ..log("entries length before .where: ${tasks.length}");

  final entries = tasks.where((task) {
    final dateFrom = from.toDateOnly;
    final dateTo = to.toDateOnly;
    final taskDay = task.day.toDateOnly;

    return taskDay.compareTo(dateFrom) >= 0 && taskDay.compareTo(dateTo) <= 0;
  }).toList();

  crashProvider.log("entries length after .where: ${entries.length}");

  return entries;
}

@riverpod
Future<List<TaskHistoryEntry>> historyEntriesBetweenSelectedDateRange(
  Ref ref,
) async {
  final taskHistoryEntries = await ref.read(taskHistoryEntriesProvider.future);
  final (from, to) = ref.watch(historyRateRangesFilterProvider);

  final crashProvider = ref.read(crashReporterProvider)
    ..log("historyEntriesBetweenSelectedDateRangeProvider")
    ..setCustomKey("from", from.toIso8601String())
    ..setCustomKey("to", to.toIso8601String())
    ..log("entries length before .where: ${taskHistoryEntries.length}");

  final entries = taskHistoryEntries.where((task) {
    final dateFrom = DateTime(from.year, from.month, from.day);
    final dateTo = DateTime(to.year, to.month, to.day);
    final taskDay = DateTime(
      task.timestamp.year,
      task.timestamp.month,
      task.timestamp.day,
    );
    return taskDay.compareTo(dateFrom) >= 0 && taskDay.compareTo(dateTo) <= 0;
  }).toList();

  crashProvider.log("entries length after .where: ${entries.length}");

  return entries;
}
