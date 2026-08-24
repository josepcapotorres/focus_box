import '../../domain/entities/task.dart';
import '../../domain/enums/task_status.dart';

class TaskModel extends Task {
  const TaskModel(
    super.id,
    super.name,
    super.status,
    super.timeAlreadyDone,
    super.timeTotal,
    super.day,
    super.startedAt,
  );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      json["id"] as String,
      json["name"],
      _statusFromJson(json["status"] as int),
      Duration(milliseconds: json["time_already_done"] as int),
      Duration(milliseconds: json["time_total"] as int),
      DateTime.fromMicrosecondsSinceEpoch(json["day"]),
      json["started_at"] != null
          ? DateTime.fromMicrosecondsSinceEpoch(json["started_at"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "status": _statusToJson(),
      "time_already_done": timeAlreadyDone.inMilliseconds,
      "time_total": timeTotal.inMilliseconds,
      "day": day.microsecondsSinceEpoch,
      "started_at": startedAt?.microsecondsSinceEpoch,
    };
  }

  static TaskStatus _statusFromJson(int statusNum) {
    return switch (statusNum) {
      1 => .inProgress,
      2 => .completed,
      3 => .paused,
      4 => .exceeded,
      5 => .pending,
      6 => .exceededInProgress,
      _ => .pending,
    };
  }

  int _statusToJson() {
    return switch (status) {
      .inProgress => 1,
      .completed => 2,
      .paused => 3,
      .exceeded => 4,
      .pending => 5,
      .exceededInProgress => 6,
    };
  }

  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      task.id,
      task.name,
      task.status,
      task.timeAlreadyDone,
      task.timeTotal,
      task.day,
      task.startedAt,
    );
  }
}
