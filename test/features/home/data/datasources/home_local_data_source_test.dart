import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:focus_box/core/data/models/task_model.dart';
import 'package:focus_box/features/home/data/datasources/home_local_data_source.dart';
import 'package:focus_box/features/home/data/datasources/home_local_data_source_impl.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

class MockBox extends Mock implements Box {}

void main() {
  late MockBox mockBox;
  late HomeLocalDataSource homeLocalDataSource;

  setUp(() {
    mockBox = MockBox();
    homeLocalDataSource = HomeLocalDataSourceImpl(mockBox);
  });

  group("watchTasks", () {
    test("should emit TaskModels initially", () async {
      // Arrange
      final taskModels = [populateTaskModel()];

      final taskModelMaps = taskModels.map((e) => e.toJson()).toList();

      when(() => mockBox.values).thenReturn(taskModelMaps);
      when(() => mockBox.watch()).thenAnswer((_) => const Stream.empty());

      // Act
      final tasks = homeLocalDataSource.watchTasks();

      // Assert
      await expectLater(tasks, emits(taskModels));
    });

    test("should emit TaskModels when box changes", () async {
      // Arrange
      int callCount = 0;

      final firstTaskModels = [populateTaskModel()];

      final secondTaskModels = [populateTaskModel()];

      final firstTaskModelMaps = firstTaskModels
          .map((e) => e.toJson())
          .toList();
      final secondTaskModelMaps = secondTaskModels
          .map((e) => e.toJson())
          .toList();

      when(() => mockBox.values).thenAnswer((_) {
        callCount++;

        if (callCount == 1) {
          return firstTaskModelMaps;
        }

        return secondTaskModelMaps;
      });

      final boxEventController = StreamController<BoxEvent>();

      when(() => mockBox.watch()).thenAnswer((_) => boxEventController.stream);

      // Act
      final tasksStream = homeLocalDataSource.watchTasks();

      // Assert
      final expectation = expectLater(
        tasksStream,
        emitsInOrder([firstTaskModels, secondTaskModels]),
      );

      boxEventController.add(
        BoxEvent(
          secondTaskModelMaps.first["id"],
          secondTaskModelMaps.first,
          false,
        ),
      );

      await expectation;

      verify(() => mockBox.values).called(2);

      await boxEventController.close();
    });
  });

  test("should save or edit a task model", () async {
    // Arrange
    final taskModel = populateTaskModel();

    when(
      () => mockBox.put(taskModel.id, taskModel.toJson()),
    ).thenAnswer((_) async {});

    // Act
    await homeLocalDataSource.saveOrEditTask(taskModel);

    // Assert
    verify(() => mockBox.put(taskModel.id, taskModel.toJson())).called(1);
  });

  test("should delete task", () async {
    // Arrange
    final taskId = const Uuid().v4();

    when(() => mockBox.delete(taskId)).thenAnswer((_) async {});

    // Act
    await homeLocalDataSource.deleteTask(taskId);

    // Assert
    verify(() => mockBox.delete(taskId)).called(1);
  });

  group("getInterruptedTask", () {
    test("should return Task instance from list of tasks", () async {
      // Arrange
      final taskModel = TaskModel(
        const Uuid().v4(),
        "task 1",
        .inProgress,
        .zero,
        .zero,
        DateTime.now(),
        DateTime.now(),
      );

      final taskModelsMap = taskModel.toJson();

      when(() => mockBox.values).thenReturn([taskModelsMap]);

      // Act
      final inProgressTasks = await homeLocalDataSource.getInterruptedTask();

      // Assert
      verify(() => mockBox.values).called(1);

      expect(inProgressTasks, isNotNull);
      expect(inProgressTasks, isA<TaskModel>());
      expect(inProgressTasks, taskModel);
    });

    test("should return null Task because of status != .inProgress", () async {
      // Arrange
      final taskModel = TaskModel(
        const Uuid().v4(),
        "task 1",
        .paused,
        .zero,
        .zero,
        DateTime.now(),
        DateTime.now(),
      );

      final taskModelsMap = taskModel.toJson();

      when(() => mockBox.values).thenReturn([taskModelsMap]);

      // Act
      final inProgressTasks = await homeLocalDataSource.getInterruptedTask();

      // Assert
      verify(() => mockBox.values).called(1);

      expect(inProgressTasks, isNull);
    });

    test("should return null Task because of startedAt = null", () async {
      // Arrange
      final taskModel = TaskModel(
        const Uuid().v4(),
        "task 1",
        .paused,
        .zero,
        .zero,
        DateTime.now(),
        null,
      );

      final taskModelsMap = taskModel.toJson();

      when(() => mockBox.values).thenReturn([taskModelsMap]);

      // Act
      final inProgressTasks = await homeLocalDataSource.getInterruptedTask();

      // Assert
      verify(() => mockBox.values).called(1);

      expect(inProgressTasks, isNull);
    });
  });
}

TaskModel populateTaskModel() {
  return TaskModel(
    const Uuid().v4(),
    "task 1",
    .pending,
    .zero,
    .zero,
    DateTime.now(),
    null,
  );
}
