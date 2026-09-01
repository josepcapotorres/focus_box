import '../../../../core/data/models/task_model.dart';

abstract class HomeLocalDataSource {
  Stream<List<TaskModel>> watchTasks();

  Future<void> saveOrEditTask(TaskModel taskModel);

  Future<void> deleteTask(String taskId);

  Future<TaskModel?> getInterruptedTask();
}
