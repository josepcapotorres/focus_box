import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/managers/crash_reporter.dart';
import '../../data/repositories/task_details_repository_impl.dart';
import '../../domain/entities/task_history_entry.dart';

part 'task_details_history_provider.g.dart';

@riverpod
Future<List<TaskHistoryEntry>> taskHistoryEntries(Ref ref) async {
  final taskDetailsRepository = await ref.watch(
    taskDetailsRepositoryProvider.future,
  );

  try {
    return taskDetailsRepository.getHistoryEntries();
  } catch (e, s) {
    ref.read(crashReporterProvider).recordError(e, s);
    return [];
  }
}

@riverpod
Future<List<TaskHistoryEntry>> taskHistoryEntriesByTaskId(
  Ref ref,
  String taskId,
) async {
  final taskDetailsRepository = await ref.watch(
    taskDetailsRepositoryProvider.future,
  );

  try {
    return taskDetailsRepository.getHistoryEntriesByTaskId(taskId);
  } catch (e, s) {
    ref.read(crashReporterProvider)
      ..log("taskHistoryEntriesByTaskId()")
      ..setCustomKey("task_id", taskId)
      ..recordError(e, s);
    return [];
  }
}

@riverpod
Future<void> taskDetailsHistoryAddEntry(Ref ref, TaskHistoryEntry entry) async {
  final taskDetailsRepository = await ref.read(
    taskDetailsRepositoryProvider.future,
  );

  ref.read(crashReporterProvider)
    ..log(
      "task_details_history_provider.dart > taskDetailsHistoryAddEntry > storing entry",
    )
    ..setCustomKey("entry_task_id", entry.taskId)
    ..setCustomKey("entry_status", entry.toStatus);

  await taskDetailsRepository.addEntry(entry);
}
