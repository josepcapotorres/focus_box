import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/extensions/datetime_extension.dart';

part 'home_selected_date_filter.g.dart';

@riverpod
class HomeSelectedDateFilter extends _$HomeSelectedDateFilter {
  @override
  DateTime build() => DateTime.now();

  void setDate(DateTime dateTime) {
    state = dateTime;
  }

  void setPreviousDay() {
    state = state.subtract(const Duration(days: 1));
  }

  void setNextDay() {
    state = state.add(const Duration(days: 1));
  }

  bool get prevButtonEnabled {
    final firstSelectableDate = state.getFirstDayOfCurrentMonth().toDateOnly;

    return firstSelectableDate.compareTo(state.toDateOnly) < 0;
  }

  bool get nextButtonEnabled {
    final now = DateTime.now();

    final lastSelectableDate = now.toDateOnly.add(const Duration(days: 7));

    return lastSelectableDate.compareTo(state.toDateOnly) > 0;
  }
}
