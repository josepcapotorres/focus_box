import 'package:equatable/equatable.dart';

import '../../../../core/domain/enums/task_status.dart';

class FocusSessionEntity extends Equatable {
  final String taskId;
  final TaskStatus status;

  const FocusSessionEntity({required this.taskId, required this.status});

  FocusSessionEntity copyWith({TaskStatus? status}) {
    return FocusSessionEntity(taskId: taskId, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [taskId, status];
}
