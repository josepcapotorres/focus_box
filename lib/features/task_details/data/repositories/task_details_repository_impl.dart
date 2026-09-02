import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/task_history_entry.dart';
import '../datasources/task_details_local_data_source.dart';
import '../datasources/task_details_local_data_source_impl.dart';
import '../models/task_history_entry_model.dart';
import 'task_details_repository.dart';

part 'task_details_repository_impl.g.dart';

class TaskDetailsRepositoryImpl extends TaskDetailsRepository {
  final TaskDetailsLocalDataSource _localDataSource;

  TaskDetailsRepositoryImpl(this._localDataSource);

  @override
  Future<void> addEntry(TaskHistoryEntry entry) async {
    await _localDataSource.addEntry(TaskHistoryEntryModel.fromEntity(entry));
  }

  @override
  List<TaskHistoryEntry> getHistoryEntries() {
    return _localDataSource
        .getHistoryEntries()
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  List<TaskHistoryEntry> getHistoryEntriesByTaskId(String taskId) {
    return _localDataSource.getHistoryEntriesByTaskId(taskId);
  }

  @override
  Future<void> deleteTaskIdEntries(List<String> entryIdsToDelete) async {
    await _localDataSource.removeEntries(entryIdsToDelete);
  }
}

@riverpod
Future<TaskDetailsRepository> taskDetailsRepository(Ref ref) async {
  final localRepository = await ref.read(
    taskDetailsLocalDataSourceProvider.future,
  );

  return TaskDetailsRepositoryImpl(localRepository);
}
