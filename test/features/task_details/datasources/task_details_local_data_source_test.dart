import 'package:flutter_test/flutter_test.dart';
import 'package:focus_box/features/task_details/data/datasources/task_details_local_data_source.dart';
import 'package:focus_box/features/task_details/data/datasources/task_details_local_data_source_impl.dart';
import 'package:focus_box/features/task_details/data/models/task_history_entry_model.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockBox extends Mock implements Box {}

void main() {
  late MockBox mockBox;
  late TaskDetailsLocalDataSource sut;

  setUp(() {
    mockBox = MockBox();
    sut = TaskDetailsLocalDataSourceImpl(mockBox);
  });

  group("addEntry", () {
    test("should call box.put to add a new entry successfully", () async {
      // Arrange
      final taskHistoryEntryModel = populateTaskHistoryEntryModel();
      final taskHistoryEntryJson = taskHistoryEntryModel.toJson();

      when(
        () => mockBox.put(taskHistoryEntryModel.id, taskHistoryEntryJson),
      ).thenAnswer((_) async {});

      // Act
      await sut.addEntry(taskHistoryEntryModel);

      // Assert
      verify(
        () => mockBox.put(taskHistoryEntryModel.id, taskHistoryEntryJson),
      ).called(1);
    });
  });

  group("getHistoryEntries", () {
    test(
      "should return a filled list of TaskHistoryEntryModel instance",
      () async {
        // Arrange
        final mockedEntries = [populateTaskHistoryEntryModel()];
        final mockedEntriesMap = convertEntriesToMap(mockedEntries);

        when(() => mockBox.values).thenReturn(mockedEntriesMap);

        // Act
        final entries = sut.getHistoryEntries();

        // Assert
        verify(() => mockBox.values).called(1);

        expect(entries, mockedEntries);
      },
    );

    test("should return an empty list", () async {
      // Arrange
      final mockedEntries = <TaskHistoryEntryModel>[];
      final mockedEntriesMap = convertEntriesToMap(mockedEntries);

      when(() => mockBox.values).thenReturn(mockedEntriesMap);

      // Act
      final entries = sut.getHistoryEntries();

      // Assert
      verify(() => mockBox.values).called(1);
      expect(entries, mockedEntries);
      expect(entries, isEmpty);
    });
  });

  group("getHistoryEntriesByTaskId", () {
    test("should return a filled list of TaskHistoryEntryModel", () async {
      // Arrange
      final entries = [populateTaskHistoryEntryModel()];
      final entriesMap = convertEntriesToMap(entries);

      when(() => mockBox.values).thenReturn(entriesMap);

      // Act
      final entry = sut.getHistoryEntriesByTaskId("taskUuid");

      // Assert
      verify(() => mockBox.values).called(1);

      expect(entry.length, 1);
      expect(entries.first, entry.first);
      expect(entries.first, isA<TaskHistoryEntryModel>());
    });

    test("should return an empty list", () async {
      // Arrange
      final entries = [populateTaskHistoryEntryModel()];
      final entriesMap = convertEntriesToMap(entries);

      when(() => mockBox.values).thenReturn(entriesMap);

      // Act
      final entry = sut.getHistoryEntriesByTaskId("anythingUuid");

      // Assert
      verify(() => mockBox.values).called(1);

      expect(entry, isEmpty);
    });
  });

  group("removeEntries", () {
    test(
      "should call removeEntries successfully passing a filled id list",
      () async {
        // Arrange
        final entryIdsToDelete = ["uuid", "uuid2"];

        performRemoveEntriesTest(mockBox, sut, entryIdsToDelete);
      },
    );

    test(
      "should call removeEntries successfully passing an empty id list",
      () async {
        // Arrange
        final entryIdsToDelete = <String>[];

        performRemoveEntriesTest(mockBox, sut, entryIdsToDelete);
      },
    );
  });
}

List<Map<String, dynamic>> convertEntriesToMap(
  List<TaskHistoryEntryModel> entries,
) {
  return entries.map((e) => e.toJson()).toList();
}

TaskHistoryEntryModel populateTaskHistoryEntryModel() {
  return TaskHistoryEntryModel(
    id: "uuid",
    taskId: "taskUuid",
    timestamp: DateTime.now(),
    toStatus: .inProgress,
  );
}

void performRemoveEntriesTest(
  MockBox mockBox,
  TaskDetailsLocalDataSource sut,
  List<String> entryIdsToDelete,
) async {
  // Arrange
  final entryIdsToDelete = ["uuid", "uuid2"];

  when(() => mockBox.deleteAll(entryIdsToDelete)).thenAnswer((_) async {});

  // Act
  await sut.removeEntries(entryIdsToDelete);

  // Assert
  verify(() => mockBox.deleteAll(entryIdsToDelete)).called(1);
}
