import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:focus_box/core/data/models/task_model.dart';
import 'package:focus_box/core/domain/entities/task.dart';
import 'package:focus_box/features/home/data/datasources/home_local_data_source.dart';
import 'package:focus_box/features/home/domain/repositories/home_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../data/datasources/home_local_data_source_test.dart';

class MockHomeLocalDataSource extends Mock implements HomeLocalDataSource {}

void main() {
  late MockHomeLocalDataSource mockLocalDataSource;
  late HomeRepository homeRepository;

  setUp(() {
    mockLocalDataSource = MockHomeLocalDataSource();
    homeRepository = HomeRepository(mockLocalDataSource);
  });

  test("should emit TaskModel instances", () async {
    // Arrange
    final taskModel = populateTaskModel();
    final expectedTasks = [taskModel.toEntity()];
    final boxTaskModelController = StreamController<List<TaskModel>>();

    when(
      () => mockLocalDataSource.watchTasks(),
    ).thenAnswer((_) => boxTaskModelController.stream);

    // Act
    final tasksStream = homeRepository.watchTasks();

    // Assert
    final expectation = expectLater(tasksStream, emitsInOrder([expectedTasks]));

    boxTaskModelController.add([taskModel]);

    await expectation;

    verify(() => mockLocalDataSource.watchTasks()).called(1);

    boxTaskModelController.close();
  });

  test("should save of edit task", () async {
    // Arrange
    final taskModel = populateTaskModel();
    final task = taskModel.toEntity();

    when(
      () => mockLocalDataSource.saveOrEditTask(taskModel),
    ).thenAnswer((_) async {});

    // Act
    await homeRepository.saveOrEditTask(task);

    // Assert
    verify(() => mockLocalDataSource.saveOrEditTask(taskModel)).called(1);
    expect(taskModel, isA<TaskModel>());
    expect(task, isA<Task>());
  });

  test("should delete task", () async {
    // Arrange
    const taskId = "taskIdNumber";
    when(() => mockLocalDataSource.deleteTask(taskId)).thenAnswer((_) async {});

    // Act
    await homeRepository.deleteTask(taskId);

    // Assert
    verify(() => mockLocalDataSource.deleteTask(taskId)).called(1);
  });

  test("should get interrupted task", () async {
    // Arrange
    final taskModel = populateTaskModel();
    final task = taskModel.toEntity();

    when(
      () => mockLocalDataSource.getInterruptedTask(),
    ).thenAnswer((_) async => taskModel);

    // Act
    final interruptedTask = await homeRepository.getInterruptedTask();

    // Assert
    verify(() => mockLocalDataSource.getInterruptedTask()).called(1);

    expect(interruptedTask, isNotNull);
    expect(interruptedTask, task);
    expect(interruptedTask, isA<Task>());
  });

  test("should get a null interrupted task", () async {
    // Arrange
    when(
      () => mockLocalDataSource.getInterruptedTask(),
    ).thenAnswer((_) async => null);

    // Act
    final interruptedTask = await homeRepository.getInterruptedTask();

    // Assert
    verify(() => mockLocalDataSource.getInterruptedTask()).called(1);

    expect(interruptedTask, isNull);
  });
}
