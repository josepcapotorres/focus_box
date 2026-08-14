import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/format/deep_cast.dart';
import '../models/task_history_entry_model.dart';

part 'task_details_local_data_source_impl.g.dart';

class TaskDetailsLocalDataSourceImpl {
  final Box<dynamic> _box;

  TaskDetailsLocalDataSourceImpl(this._box);

  Future<void> addEntry(TaskHistoryEntryModel entryModel) async {
    await _box.put(entryModel.id, entryModel.toJson());
  }

  List<TaskHistoryEntryModel> getHistoryEntries() {
    return _box.values
        .map((e) => TaskHistoryEntryModel.fromJson(deepCast(e)))
        .toList();
  }

  List<TaskHistoryEntryModel> getHistoryEntriesByTaskId(String taskId) {
    return getHistoryEntries().where((e) => e.taskId == taskId).toList();
  }

  Future<void> removeEntries(List<String> entryIdsToDelete) async {
    await _box.deleteAll(entryIdsToDelete);
  }
}

@Riverpod(keepAlive: true)
Future<TaskDetailsLocalDataSourceImpl> taskDetailsLocalDataSource(
  Ref ref,
) async {
  return TaskDetailsLocalDataSourceImpl(await Hive.openBox("history"));
}
