import 'package:riverpod_annotation/riverpod_annotation.dart';

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
        ..setCustomKey("from", today)
        ..setCustomKey("to", today);
      break;
    case .currentWeek:
      result = (_getFirstDayOfCurrentWeek(today), _getLastDayOfWeek(today));
      crashProvider
        ..log(
          "history_date_ranges_filter_provider.dart > historyRateRangesFilterProvider",
        )
        ..setCustomKey("from", _getFirstDayOfCurrentWeek(today))
        ..setCustomKey("to", _getLastDayOfWeek(today));
      break;
    case .currentMonth:
      result = (_getFirstDayOfCurrentMonth(today), _getLastDayOfMonth(today));
      crashProvider
        ..log(
          "history_date_ranges_filter_provider.dart > historyRateRangesFilterProvider",
        )
        ..setCustomKey("from", _getFirstDayOfCurrentMonth(today))
        ..setCustomKey("to", _getLastDayOfMonth(today));
      break;
  }

  return result;
}

DateTime _getFirstDayOfCurrentWeek(DateTime today) {
  return today.subtract(Duration(days: today.weekday - DateTime.monday));
}

DateTime _getLastDayOfWeek(DateTime date) {
  return date.add(Duration(days: DateTime.sunday - date.weekday));
}

DateTime _getFirstDayOfCurrentMonth(DateTime today) {
  return DateTime(today.year, today.month, 1);
}

DateTime _getLastDayOfMonth(DateTime date) {
  return DateTime(date.year, date.month + 1, 0);
}
