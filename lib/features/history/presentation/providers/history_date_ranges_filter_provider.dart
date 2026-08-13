import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'history_current_filter_provider.dart';

part 'history_date_ranges_filter_provider.g.dart';

@riverpod
(DateTime, DateTime) historyRateRangesFilter(Ref ref) {
  final currentFilter = ref.watch(historyCurrentFilterProvider);
  final today = DateTime.now();

  return switch (currentFilter) {
    .today => (today, today),
    .currentWeek => (
      _getFirstDayOfCurrentWeek(today),
      _getLastDayOfWeek(today),
    ),
    .currentMonth => (
      _getFirstDayOfCurrentMonth(today),
      _getLastDayOfMonth(today),
    ),
  };
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
