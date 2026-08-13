import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/enums/task_filter_enum.dart';

part 'task_details_current_filter_provider.g.dart';

@riverpod
class TaskDetailsCurrentFilter extends _$TaskDetailsCurrentFilter {
  @override
  TaskFilterEnum build() => .today;

  void setFilter(TaskFilterEnum filter) {
    state = filter;
  }
}
