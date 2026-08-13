import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/data/models/task_model.dart';
import '../../../../core/domain/entities/task.dart';
import '../../../../core/providers/ticker_provider.dart';
import '../../../home/domain/repositories/home_repository.dart';
import '../../../home/presentation/providers/home_tasks_provider.dart';
import '../../../task_details/domain/entities/task_history_entry.dart';
import '../../../task_details/presentation/providers/task_details_history_provider.dart';
import '../../domain/entities/focus_session_entity.dart';

part 'focus_session_provider.g.dart';

@Riverpod(keepAlive: true)
class FocusSession extends _$FocusSession {
  @override
  FocusSessionEntity? build() {
    ref.listen<Duration>(tickerProvider, (prev, elapsed) {
      final session = state;

      if (session == null) return;

      final task = ref.read(currentTaskProvider(session.taskId));

      if (task == null) return;

      // La tarea ha llegado al tiempo máximo.
      if (elapsed >= task.timeTotal) {
        setToDone();

        return;
      }

      // La tarea sigue ejecutándose.
      final updatedTask = task.copyWith(timeAlreadyDone: elapsed);

      ref.read(homeTasksProvider.notifier).updateTask(updatedTask);
    });

    return null;
  }

  void startTask(Task task) {
    if (state?.status == .inProgress) {
      pause();
    }

    state = FocusSessionEntity(taskId: task.id, status: .inProgress);

    ref.read(tickerProvider.notifier).startTimer(task.timeAlreadyDone);

    final updatedTask = task.copyWith(status: .inProgress);

    _saveTask(updatedTask);

    ref.read(
      taskDetailsHistoryAddEntryProvider(
        TaskHistoryEntry(
          taskId: task.id,
          timestamp: DateTime.now(),
          toStatus: .inProgress,
        ),
      ),
    );
  }

  Future<void> pause() async {
    final session = state;
    final elapsed = ref.read(tickerProvider.notifier).pauseTimer();

    if (session == null) {
      await _pauseFoundInProgressTask(elapsed);
      return;
    }

    final task = ref.read(currentTaskProvider(session.taskId));
    if (task == null) return;

    final updatedTask = task.copyWith(
      status: .paused,
      timeAlreadyDone: elapsed,
    );

    await _saveTask(updatedTask);

    ref.read(
      taskDetailsHistoryAddEntryProvider(
        TaskHistoryEntry(
          taskId: session.taskId,
          timestamp: DateTime.now(),
          toStatus: .paused,
        ),
      ),
    );

    state = session.copyWith(status: .paused);
  }

  Future<void> _saveTask(Task task) async {
    final repository = await ref.read(homeRepositoryProvider.future);

    await repository.saveOrEditTask(TaskModel.fromEntity(task));
  }

  void resumeTimer() {
    final session = state;
    if (session == null) return;

    final task = ref.read(currentTaskProvider(state?.taskId));
    if (task == null) return;

    final updatedTask = task.copyWith(status: .inProgress);

    ref.read(homeTasksProvider.notifier).updateTask(updatedTask);

    state = state?.copyWith(status: .inProgress);

    ref.read(tickerProvider.notifier).resumeTimer();

    /*ref
        .read(homeTasksProvider.notifier)
        .saveElapsedTime(taskId: state!.taskId, elapsed: task.timeAlreadyDone);*/

    ref.read(
      taskDetailsHistoryAddEntryProvider(
        TaskHistoryEntry(
          taskId: state!.taskId,
          timestamp: DateTime.now(),
          toStatus: .inProgress,
        ),
      ),
    );
  }

  void add15minToTotal() {
    if (state == null) return;
    final task = ref.read(currentTaskProvider(state!.taskId));
    final updatedTask = task?.copyWith(
      timeTotal: task.timeTotal + const Duration(minutes: 15),
    );

    if (updatedTask == null) return;

    ref.read(homeTasksProvider.notifier).updateTask(updatedTask);
  }

  void setToDone() {
    final session = state;
    if (session == null) return;

    final task = ref.read(currentTaskProvider(session.taskId));
    if (task == null) return;

    ref.read(tickerProvider.notifier).pauseTimer();

    final updatedTask = task.copyWith(
      timeAlreadyDone: task.timeTotal,
      status: .completed,
    );

    ref.read(homeTasksProvider.notifier).updateTask(updatedTask);

    _saveTask(updatedTask);

    ref.read(
      taskDetailsHistoryAddEntryProvider(
        TaskHistoryEntry(
          taskId: session.taskId,
          timestamp: DateTime.now(),
          toStatus: .completed,
        ),
      ),
    );

    state = null;
  }

  Future<void> _pauseFoundInProgressTask(Duration elapsed) async {
    final tasks = ref.read(tasksForTodayProvider);

    final task = tasks.where((e) => e.status == .inProgress).firstOrNull;

    if (task == null) return;

    final updatedTask = task.copyWith(
      status: .paused,
      timeAlreadyDone: elapsed,
    );

    await _saveTask(updatedTask);

    ref.read(
      taskDetailsHistoryAddEntryProvider(
        TaskHistoryEntry(
          taskId: updatedTask.id,
          timestamp: DateTime.now(),
          toStatus: .paused,
        ),
      ),
    );
  }
}
