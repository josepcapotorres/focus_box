import '../../../../core/domain/enums/task_status.dart';
import '../../domain/entities/task_history_entry.dart';

class TaskHistoryEntryModel extends TaskHistoryEntry {
  TaskHistoryEntryModel({
    required super.id,
    required super.taskId,
    required super.timestamp,
    required super.toStatus,
  });

  factory TaskHistoryEntryModel.fromJson(Map<String, dynamic> json) {
    return TaskHistoryEntryModel(
      id: json["entry_id"],
      taskId: json["task_id"],
      timestamp: DateTime.fromMicrosecondsSinceEpoch(json["timestamp"]),
      toStatus: _statusFromJson(json["to_status"] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "entry_id": id,
      "task_id": taskId,
      "timestamp": timestamp.microsecondsSinceEpoch,
      "to_status": _statusToJson(toStatus),
    };
  }

  factory TaskHistoryEntryModel.fromEntity(TaskHistoryEntry entry) {
    return TaskHistoryEntryModel(
      id: entry.id,
      taskId: entry.taskId,
      timestamp: entry.timestamp,
      toStatus: entry.toStatus,
    );
  }

  static TaskStatus _statusFromJson(int statusNum) {
    return switch (statusNum) {
      1 => .inProgress,
      2 => .completed,
      3 => .paused,
      4 => .exceeded,
      5 => .pending,
      _ => .pending,
    };
  }

  int _statusToJson(TaskStatus status) {
    return switch (status) {
      .inProgress => 1,
      .completed => 2,
      .paused => 3,
      .exceeded => 4,
      .pending => 5,
    };
  }
}
