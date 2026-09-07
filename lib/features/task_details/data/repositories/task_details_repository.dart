import '../../domain/entities/task_history_entry.dart';

abstract class TaskDetailsRepository {
  Future<void> addEntry(TaskHistoryEntry entry);

  Stream<List<TaskHistoryEntry>> watchEntries();

  List<TaskHistoryEntry> getHistoryEntriesByTaskId(String taskId);

  Future<void> deleteTaskIdEntries(List<String> entryIdsToDelete);
}
