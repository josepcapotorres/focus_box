import '../models/task_history_entry_model.dart';

abstract class TaskDetailsLocalDataSource {
  Future<void> addEntry(TaskHistoryEntryModel entryModel);

  List<TaskHistoryEntryModel> getHistoryEntries();

  List<TaskHistoryEntryModel> getHistoryEntriesByTaskId(String taskId);

  Future<void> removeEntries(List<String> entryIdsToDelete);
}
