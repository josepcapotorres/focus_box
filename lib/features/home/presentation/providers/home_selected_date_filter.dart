import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_selected_date_filter.g.dart';

@riverpod
class HomeSelectedDateFilter extends _$HomeSelectedDateFilter {
  @override
  DateTime build() => DateTime.now();

  void setDate(DateTime dateTime) {
    state = dateTime;
  }
}
