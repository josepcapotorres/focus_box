import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/enums/history_range_enum.dart';

part 'history_current_filter_provider.g.dart';

@riverpod
class HistoryCurrentFilter extends _$HistoryCurrentFilter {
  @override
  HistoryRange build() => HistoryRange.today;

  void setCurrentFilter(HistoryRange filter) {
    state = filter;
  }
}
