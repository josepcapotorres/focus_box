import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/domain/entities/task.dart';
import '../../domain/repositories/home_repository.dart';
import 'task_details_current_filter_provider.dart';

part 'home_tasks_provider.g.dart';

@riverpod
class HomeTasks extends _$HomeTasks {
  @override
  Stream<List<Task>> build() async* {
    final homeRepository = await ref.watch(homeRepositoryProvider.future);
    yield* homeRepository.watchTasks();
  }

  void updateTask(Task updatedTask) {
    final currentTasks = state.value ?? [];

    state = AsyncData([
      for (final task in currentTasks)
        task.id == updatedTask.id ? updatedTask : task,
    ]);
  }
}

@riverpod
Task? currentTask(Ref ref, String? taskId) {
  final asyncTasks = ref.watch(homeTasksProvider);

  final tasks = asyncTasks.value ?? [];
  final task = tasks.where((e) => e.id == taskId).firstOrNull;

  return task;
}

@riverpod
List<Task> tasksForToday(Ref ref) {
  final tasks = ref.watch(homeTasksProvider).value ?? [];

  final today = DateTime.now();
  final todayFormatted = DateTime(today.year, today.month, today.day);

  return tasks.where((e) {
    final currentDateFormatted = DateTime(e.day.year, e.day.month, e.day.day);
    return todayFormatted == currentDateFormatted;
  }).toList();
}

@riverpod
List<Task> tasksForTomorrow(Ref ref) {
  final tasks = ref.watch(homeTasksProvider).value ?? [];

  final tomorrow = DateTime.now().add(const Duration(days: 1));
  final todayFormatted = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);

  return tasks.where((e) {
    final currentDateFormatted = DateTime(e.day.year, e.day.month, e.day.day);
    return todayFormatted == currentDateFormatted;
  }).toList();
}

@riverpod
Future<List<Task>> homeFilteredTasks(Ref ref) async {
  final currentFilter = ref.watch(taskDetailsCurrentFilterProvider);
  final tasksForToday = ref.watch(tasksForTodayProvider);
  final tasksForTomorrow = ref.watch(tasksForTomorrowProvider);

  return switch (currentFilter) {
    .today => tasksForToday,
    .nextDay => tasksForTomorrow,
  };
}
