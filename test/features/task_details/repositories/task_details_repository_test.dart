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

      when(
        () => mockLocalDataSource.getHistoryEntries(),
      ).thenReturn(entryModels);

      // Act
      final result = sut.getHistoryEntries();

      // Assert
      verify(() => mockLocalDataSource.getHistoryEntries()).called(1);

      expect(result, entries);
    });

    test("should return an empty list", () async {
      // Arrange
      final entries = <TaskHistoryEntry>[];
      final entryModels = convertEntriesToModels(entries);

      when(
        () => mockLocalDataSource.getHistoryEntries(),
      ).thenReturn(entryModels);

      // Act
      final result = sut.getHistoryEntries();

      // Assert
      verify(() => mockLocalDataSource.getHistoryEntries()).called(1);

      expect(result, isEmpty);
    });
  });

  group("getHistoryEntriesByTaskId", () {
    test(
      "should return a filled entry list given a found task id in the list",
      () async {
        // Arrange
        const taskId = "uuid";

        final entries = populateEntries();

        final filteredEntries = [
          populateTaskHistoryEntry(id: "uuid", toStatus: .pending),
          populateTaskHistoryEntry(id: "uuid", toStatus: .inProgress),
        ];

        final entryModels = convertEntriesToModels(entries);
        final filteredEntryModels = convertEntriesToModels(filteredEntries);

        when(
          () => mockLocalDataSource.getHistoryEntries(),
        ).thenReturn(entryModels);

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
        final entryModels = convertEntriesToModels(entries);
        final filteredEntries = <TaskHistoryEntryModel>[];
        final filteredEntryModels = convertEntriesToModels(filteredEntries);

        when(
          () => mockLocalDataSource.getHistoryEntriesByTaskId(taskId),
        ).thenReturn(filteredEntryModels);

        when(
          () => mockLocalDataSource.getHistoryEntries(),
        ).thenReturn(entryModels);

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
