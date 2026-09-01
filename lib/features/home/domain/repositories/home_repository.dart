import 'package:focus_box/core/data/models/task_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/domain/entities/task.dart';
import '../../data/datasources/home_local_data_source.dart';
import '../../data/datasources/home_local_data_source_impl.dart';

part 'home_repository.g.dart';

class HomeRepository {
  final HomeLocalDataSource _localDataSource;

  const HomeRepository(this._localDataSource);

  Stream<List<Task>> watchTasks() {
    return _localDataSource.watchTasks().map(
      (tasks) => tasks.map((t) => t.toEntity()).toList(),
    );
  }

  Future<void> saveOrEditTask(Task task) async {
    final taskModel = TaskModel.fromEntity(task);
    await _localDataSource.saveOrEditTask(taskModel);
  }

  Future<void> deleteTask(String taskId) async {
    await _localDataSource.deleteTask(taskId);
  }

  Future<Task?> getInterruptedTask() async {
    final interruptedTask = await _localDataSource.getInterruptedTask();
    return interruptedTask?.toEntity();
  }
}

@riverpod
Future<HomeRepository> homeRepository(Ref ref) async {
  final localDataSource = await ref.watch(homeLocalDataSourceProvider.future);
  return HomeRepository(localDataSource);
}
