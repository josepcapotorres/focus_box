import '../../domain/entities/task_history_entry.dart';

abstract class TaskDetailsRepository {
  Future<void> addEntry(TaskHistoryEntry entry);

  List<TaskHistoryEntry> getHistoryEntries();

  List<TaskHistoryEntry> getHistoryEntriesByTaskId(String taskId);

  Future<void> deleteTaskIdEntries(List<String> entryIdsToDelete);
}
