import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/task_details_repository_impl.dart';
import '../../domain/entities/task_history_entry.dart';

part 'task_details_history_provider.g.dart';

@riverpod
Future<List<TaskHistoryEntry>> taskHistoryEntries(Ref ref) async {
  final taskDetailsRepository = await ref.watch(
    taskDetailsRepositoryProvider.future,
  );
  return taskDetailsRepository.getHistoryEntries();
}

@riverpod
Future<List<TaskHistoryEntry>> taskHistoryEntriesByTaskId(
  Ref ref,
  String taskId,
) async {
  final taskDetailsRepository = await ref.watch(
    taskDetailsRepositoryProvider.future,
  );

  return taskDetailsRepository.getHistoryEntriesByTaskId(taskId);
}

@riverpod
Future<void> taskDetailsHistoryAddEntry(Ref ref, TaskHistoryEntry entry) async {
  final taskDetailsRepository = await ref.read(
    taskDetailsRepositoryProvider.future,
  );

  await taskDetailsRepository.addEntry(entry);
}
