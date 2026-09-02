import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/extensions/datetime_extension.dart';
import '../../../../core/managers/crash_reporter.dart';
import 'history_current_filter_provider.dart';

part 'history_date_ranges_filter_provider.g.dart';

@riverpod
(DateTime, DateTime) historyRateRangesFilter(Ref ref) {
  final currentFilter = ref.watch(historyCurrentFilterProvider);
  final today = DateTime.now();

  final crashProvider = ref.read(crashReporterProvider);
  final (DateTime, DateTime) result;

  switch (currentFilter) {
    case .today:
      result = (today, today);
      crashProvider
        ..log(
          "history_date_ranges_filter_provider.dart > historyRateRangesFilterProvider",
        )
        ..setCustomKey("from", today.toIso8601String())
        ..setCustomKey("to", today.toIso8601String());
      break;
    case .currentWeek:
      final firstDayOfCurrentWeek = today.getFirstDayOfCurrentWeek();
      final lastDayOfWeek = today.getLastDayOfCurrentWeek();

      result = (firstDayOfCurrentWeek, lastDayOfWeek);

      crashProvider
        ..log(
          "history_date_ranges_filter_provider.dart > historyRateRangesFilterProvider",
        )
        ..setCustomKey("from", firstDayOfCurrentWeek.toIso8601String())
        ..setCustomKey("to", lastDayOfWeek.toIso8601String());
      break;
    case .currentMonth:
      final firstDayOfCurrentMonth = today.getFirstDayOfCurrentMonth();
      final lastDayOfCurrentMonth = today.getLastDayOfCurrentMonth();

      result = (firstDayOfCurrentMonth, lastDayOfCurrentMonth);

      crashProvider
        ..log(
          "history_date_ranges_filter_provider.dart > historyRateRangesFilterProvider",
        )
        ..setCustomKey("from", firstDayOfCurrentMonth.toIso8601String())
        ..setCustomKey("to", lastDayOfCurrentMonth.toIso8601String());
      break;
  }

  return result;
}
