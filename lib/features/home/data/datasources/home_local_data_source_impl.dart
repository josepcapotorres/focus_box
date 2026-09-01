import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/data/models/task_model.dart';
import '../../../../core/format/deep_cast.dart';
import 'home_local_data_source.dart';

part 'home_local_data_source_impl.g.dart';

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  final Box<dynamic> _box;

  HomeLocalDataSourceImpl(this._box);

  @override
  /// It might throw an exception
  Stream<List<TaskModel>> watchTasks() async* {
    yield _getTasks();

    await for (final _ in _box.watch()) {
      yield _getTasks();
    }
  }

  List<TaskModel> _getTasks() {
    return _box.values
        .map((task) => TaskModel.fromJson(deepCast(task)))
        .toList();
  }

  @override
  Future<void> saveOrEditTask(TaskModel taskModel) async {
    await _box.put(taskModel.id, taskModel.toJson());
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await _box.delete(taskId);
  }

  @override
  Future<TaskModel?> getInterruptedTask() async {
    return _getTasks()
        .where((e) => e.status == .inProgress && e.startedAt != null)
        .firstOrNull;
  }
}

@Riverpod(keepAlive: true)
Future<HomeLocalDataSource> homeLocalDataSource(Ref ref) async {
  return HomeLocalDataSourceImpl(await Hive.openBox("tasks"));
}
