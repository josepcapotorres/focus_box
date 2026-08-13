import 'package:focus_box/core/data/models/task_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/domain/entities/task.dart';
import '../../data/datasources/home_local_data_source.dart';

part 'home_repository.g.dart';

class HomeRepository {
  final HomeLocalDataSource _localDataSource;

  const HomeRepository(this._localDataSource);

  Stream<List<Task>> watchTasks() {
    return _localDataSource.watchTasks();
  }

  Future<void> saveOrEditTask(Task task) async {
    final taskModel = TaskModel.fromEntity(task);
    await _localDataSource.saveOrEditTask(taskModel);
  }
}

@riverpod
Future<HomeRepository> homeRepository(Ref ref) async {
  final localDataSource = await ref.watch(homeLocalDataSourceProvider.future);
  return HomeRepository(localDataSource);
}
