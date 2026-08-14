import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/data/models/task_model.dart';
import '../../../../core/domain/entities/task.dart';
import '../../../../core/format/deep_cast.dart';

part 'home_local_data_source.g.dart';

class HomeLocalDataSource {
  final Box<dynamic> _box;

  const HomeLocalDataSource(this._box);

  /// It might throw an exception
  Stream<List<Task>> watchTasks() async* {
    yield _getTasks();

    await for (final _ in _box.watch()) {
      yield _getTasks();
    }
  }

  List<Task> _getTasks() {
    return _box.values
        .map((task) => TaskModel.fromJson(deepCast(task)))
        .toList();
  }

  Future<void> saveOrEditTask(TaskModel taskModel) async {
    await _box.put(taskModel.id, taskModel.toJson());
  }

  Future<void> deleteTask(String taskId) async {
    await _box.delete(taskId);
  }

  Future<Task?> getInterruptedTask() async {
    return _getTasks()
        .where((e) => e.status == .inProgress && e.startedAt != null)
        .firstOrNull;
  }
}

@Riverpod(keepAlive: true)
Future<HomeLocalDataSource> homeLocalDataSource(Ref ref) async {
  return HomeLocalDataSource(await Hive.openBox("tasks"));
}
