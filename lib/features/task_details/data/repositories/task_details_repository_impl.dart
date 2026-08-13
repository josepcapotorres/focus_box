import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/task_history_entry.dart';
import '../datasources/task_details_local_data_source_impl.dart';
import '../models/task_history_entry_model.dart';

part 'task_details_repository_impl.g.dart';

class TaskDetailsRepositoryImpl {
  final TaskDetailsLocalDataSourceImpl _localDataSource;

  const TaskDetailsRepositoryImpl(this._localDataSource);

  Future<void> addEntry(TaskHistoryEntry entry) async {
    await _localDataSource.addEntry(TaskHistoryEntryModel.fromEntity(entry));
  }

  List<TaskHistoryEntry> getHistoryEntries() {
    return _localDataSource.getHistoryEntries();
  }

  List<TaskHistoryEntry> getHistoryEntriesByTaskId(String taskId) {
    return _localDataSource.getHistoryEntriesByTaskId(taskId);
  }
}

@riverpod
Future<TaskDetailsRepositoryImpl> taskDetailsRepository(Ref ref) async {
  final localRepository = await ref.read(
    taskDetailsLocalDataSourceProvider.future,
  );

  return TaskDetailsRepositoryImpl(localRepository);
}
