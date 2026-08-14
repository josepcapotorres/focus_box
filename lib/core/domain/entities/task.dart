import 'package:equatable/equatable.dart';

import '../enums/task_status.dart';

class Task extends Equatable {
  final String id;
  final String name;
  final TaskStatus status;
  final Duration timeAlreadyDone;
  final Duration timeTotal;
  final DateTime day;
  final DateTime? startedAt;

  const Task(
    this.id,
    this.name,
    this.status,
    this.timeAlreadyDone,
    this.timeTotal,
    this.day,
    this.startedAt,
  );

  Task copyWith({
    String? name,
    TaskStatus? status,
    Duration? timeAlreadyDone,
    Duration? timeTotal,
    DateTime? day,
    DateTime? startedAt,
  }) {
    return Task(
      id,
      name = name ?? this.name,
      status = status ?? this.status,
      timeAlreadyDone = timeAlreadyDone ?? this.timeAlreadyDone,
      timeTotal = timeTotal ?? this.timeTotal,
      day = day ?? this.day,
      startedAt = startedAt ?? this.startedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    status,
    timeAlreadyDone,
    timeTotal,
    day,
  ];
}
