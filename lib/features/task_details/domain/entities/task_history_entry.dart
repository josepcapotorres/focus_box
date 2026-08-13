import '../../../../core/domain/enums/task_status.dart';

class TaskHistoryEntry {
  final String taskId;
  final DateTime timestamp;
  final TaskStatus toStatus;

  const TaskHistoryEntry({
    required this.taskId,
    required this.timestamp,
    required this.toStatus,
  });
}
