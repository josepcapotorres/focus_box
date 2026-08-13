import '../../../../core/domain/enums/task_status.dart';

class FocusSessionEntity {
  final String taskId;
  final TaskStatus status;

  FocusSessionEntity({required this.taskId, required this.status});

  FocusSessionEntity copyWith({TaskStatus? status}) {
    return FocusSessionEntity(taskId: taskId, status: status ?? this.status);
  }
}
