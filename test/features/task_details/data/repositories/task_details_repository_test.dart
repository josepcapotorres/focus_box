import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:focus_box/core/domain/enums/task_status.dart';
import 'package:focus_box/features/task_details/data/datasources/task_details_local_data_source.dart';
import 'package:focus_box/features/task_details/data/models/task_history_entry_model.dart';
import 'package:focus_box/features/task_details/data/repositories/task_details_repository.dart';
import 'package:focus_box/features/task_details/data/repositories/task_details_repository_impl.dart';
import 'package:focus_box/features/task_details/domain/entities/task_history_entry.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskDetailsLocalDataSource extends Mock
    implements TaskDetailsLocalDataSource {}

void main() {
  late MockTaskDetailsLocalDataSource mockLocalDataSource;
  late TaskDetailsRepository sut;

  setUp(() {
    mockLocalDataSource = MockTaskDetailsLocalDataSource();
    sut = TaskDetailsRepositoryImpl(mockLocalDataSource);
  });

  group("addEntry", () {
    test("should call .addEntry() successfully", () async {
      // Arrange
      final entry = populateTaskHistoryEntry();

      final entryModel = TaskHistoryEntryModel.fromEntity(entry);

      when(
        () => mockLocalDataSource.addEntry(entryModel),
      ).thenAnswer((_) async {});

      // Act
      await sut.addEntry(entry);

      // Assert
      verify(() => mockLocalDataSource.addEntry(entryModel)).called(1);
    });
  });

  group("getHistoryEntries", () {
    test("should return a filled list of TaskHistoryEntry", () async {
      // Arrange
      final entries = [populateTaskHistoryEntry(), populateTaskHistoryEntry()];
      final entryModels = convertEntriesToModels(entries);
      final entriesModelController =
          StreamController<List<TaskHistoryEntryModel>>();

      when(
        () => mockLocalDataSource.watchEntries(),
      ).thenAnswer((_) => entriesModelController.stream);

      // Act
      final entriesStream = sut.watchEntries();

      // Assert
      final expectation = expectLater(entriesStream, emits(entries));

      entriesModelController.add(entryModels);

      await expectation;

      verify(() => mockLocalDataSource.watchEntries()).called(1);

      await entriesModelController.close();
    });

    test("should return an empty list", () async {
      // Arrange
      final entries = <TaskHistoryEntry>[];
      final entriesModelController =
          StreamController<List<TaskHistoryEntryModel>>();

      when(
        () => mockLocalDataSource.watchEntries(),
      ).thenAnswer((_) => entriesModelController.stream);

      // Act
      final entriesStream = sut.watchEntries();

      // Assert
      final expectation = expectLater(entriesStream, emitsInOrder(entries));

      entriesModelController.add(<TaskHistoryEntryModel>[]);

      await expectation;

      verify(() => mockLocalDataSource.watchEntries()).called(1);

      await entriesModelController.close();
    });
  });

  group("getHistoryEntriesByTaskId", () {
    test(
      "should return a filled entry list given a found task id in the list",
      () async {
        // Arrange
        const taskId = "uuid";
        final entries = populateEntries();

        final filteredEntries = entries.where((e) => e.id == taskId).toList();

        final filteredEntryModels = convertEntriesToModels(filteredEntries);

        when(
          () => mockLocalDataSource.getHistoryEntriesByTaskId(taskId),
        ).thenReturn(filteredEntryModels);

        // Act
        final result = sut.getHistoryEntriesByTaskId("uuid");

        // Assert
        verify(
          () => mockLocalDataSource.getHistoryEntriesByTaskId("uuid"),
        ).called(1);

        expect(result.length, 2);
      },
    );

    test(
      "should return an empty entry list given a not found task id in the list",
      () async {
        // Arrange
        const taskId = "taskIdUuid";
        final entries = populateEntries();
        // Empty list
        final filteredEntries = entries.where((e) => e.id == taskId).toList();
        final filteredEntryModels = convertEntriesToModels(filteredEntries);

        when(
          () => mockLocalDataSource.getHistoryEntriesByTaskId(taskId),
        ).thenReturn(filteredEntryModels);

        // Act
        final result = sut.getHistoryEntriesByTaskId(taskId);

        // Assert
        verify(
          () => mockLocalDataSource.getHistoryEntriesByTaskId(taskId),
        ).called(1);

        expect(result, isEmpty);
      },
    );
  });

  group("deleteTaskIdEntries", () {
    test(
      "should delete task passing a filled list of ids successfully",
      () async {
        // Arrange
        final entryIdsToDelete = ["uuid", "uuid2"];

        when(
          () => mockLocalDataSource.removeEntries(entryIdsToDelete),
        ).thenAnswer((_) async {});

        // Act
        await sut.deleteTaskIdEntries(entryIdsToDelete);

        // Assert
        verify(
          () => mockLocalDataSource.removeEntries(entryIdsToDelete),
        ).called(1);
      },
    );

    test(
      "should delete task passing an empty list of ids successfully",
      () async {
        // Arrange
        final entryIdsToDelete = <String>[];

        when(
          () => mockLocalDataSource.removeEntries(entryIdsToDelete),
        ).thenAnswer((_) async {});

        // Act
        await sut.deleteTaskIdEntries(entryIdsToDelete);

        // Assert
        verify(
          () => mockLocalDataSource.removeEntries(entryIdsToDelete),
        ).called(1);
      },
    );
  });
}

List<TaskHistoryEntryModel> convertEntriesToModels(
  List<TaskHistoryEntry> entries,
) {
  return entries.map((e) => TaskHistoryEntryModel.fromEntity(e)).toList();
}

TaskHistoryEntry populateTaskHistoryEntry({String? id, TaskStatus? toStatus}) {
  return TaskHistoryEntry(
    id: id ?? "uuid",
    taskId: "taskIdUuid",
    timestamp: DateTime.now(),
    toStatus: .pending,
  );
}

List<TaskHistoryEntry> populateEntries() {
  return [
    populateTaskHistoryEntry(id: "uuid", toStatus: .pending),
    populateTaskHistoryEntry(id: "uuid2", toStatus: .completed),
    populateTaskHistoryEntry(id: "uuid", toStatus: .inProgress),
  ];
}
