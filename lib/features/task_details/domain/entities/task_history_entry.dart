import 'package:equatable/equatable.dart';

import '../../../../core/domain/enums/task_status.dart';

class TaskHistoryEntry extends Equatable {
  final String id;
  final String taskId;
  final DateTime timestamp;
  final TaskStatus toStatus;

  const TaskHistoryEntry({
    required this.id,
    required this.taskId,
    required this.timestamp,
    required this.toStatus,
  });

  @override
  List<Object?> get props => [id, taskId, timestamp, toStatus];
}
