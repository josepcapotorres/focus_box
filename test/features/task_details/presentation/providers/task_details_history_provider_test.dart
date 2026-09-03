import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focus_box/core/managers/crash_reporter.dart';
import 'package:focus_box/features/task_details/data/repositories/task_details_repository.dart';
import 'package:focus_box/features/task_details/data/repositories/task_details_repository_impl.dart';
import 'package:focus_box/features/task_details/domain/entities/task_history_entry.dart';
import 'package:focus_box/features/task_details/presentation/providers/task_details_history_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskDetailRepository extends Mock implements TaskDetailsRepository {}

class MockCrashReporter extends Mock implements CrashReporter {}

void main() {
  late MockTaskDetailRepository mockTaskDetailRepository;
  late MockCrashReporter mockCrashReporter;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue("");
  });

  setUp(() {
    mockTaskDetailRepository = MockTaskDetailRepository();
    mockCrashReporter = MockCrashReporter();
    container = ProviderContainer.test(
      overrides: [
        taskDetailsRepositoryProvider.overrideWithValue(
          AsyncData(mockTaskDetailRepository),
        ),
        crashReporterProvider.overrideWithValue(mockCrashReporter),
      ],
    );
  });

  group("taskHistoryEntriesProvider", () {
    test("should return a filled list of TaskHistoryEntry", () async {
      // Arrange
      final mockEntries = populateEntries();

      when(
        () => mockTaskDetailRepository.getHistoryEntries(),
      ).thenReturn(mockEntries);

      // Act
      final entries = await container.read(taskHistoryEntriesProvider.future);

      // Assert
      verify(() => mockTaskDetailRepository.getHistoryEntries()).called(1);

      expect(entries, isNotEmpty);
    });

    test("should return an empty list", () async {
      // Arrange
      final mockEntries = <TaskHistoryEntry>[];

      when(
        () => mockTaskDetailRepository.getHistoryEntries(),
      ).thenReturn(mockEntries);

      // Act
      final entries = await container.read(taskHistoryEntriesProvider.future);

      // Assert
      verify(() => mockTaskDetailRepository.getHistoryEntries()).called(1);

      expect(entries, isEmpty);
    });
  });

  group("taskHistoryEntriesByTaskId", () {
    test(
      "should return a list of TaskHistoryEntry if task id passed is found in the list",
      () async {
        // Arrange
        final entries = populateEntries();
        const taskId = "taskId";
        final filteredEntries = entries
            .where((e) => e.taskId == taskId)
            .toList();

        when(
          () => mockTaskDetailRepository.getHistoryEntries(),
        ).thenReturn(entries);

        when(
          () => mockTaskDetailRepository.getHistoryEntriesByTaskId(taskId),
        ).thenReturn(filteredEntries);

        // Act
        final result = await container.read(
          taskHistoryEntriesByTaskIdProvider(taskId).future,
        );

        // Assert
        verify(
          () => mockTaskDetailRepository.getHistoryEntriesByTaskId(taskId),
        ).called(1);

        expect(result, isNotEmpty);
        expect(result, filteredEntries);
      },
    );

    test(
      "should return an empty list when task id passed is not found in the list",
      () async {
        // Arrange
        final entries = populateEntries();
        const taskId = "taskId22";
        final filteredEntries = entries
            .where((e) => e.taskId == taskId)
            .toList();

        when(
          () => mockTaskDetailRepository.getHistoryEntries(),
        ).thenReturn(entries);

        when(
          () => mockTaskDetailRepository.getHistoryEntriesByTaskId(taskId),
        ).thenReturn(filteredEntries);

        // Act
        final result = await container.read(
          taskHistoryEntriesByTaskIdProvider(taskId).future,
        );

        // Assert
        verify(
          () => mockTaskDetailRepository.getHistoryEntriesByTaskId(taskId),
        ).called(1);

        expect(result, isEmpty);
        expect(result, filteredEntries);
      },
    );
  });

  group("TaskDetailsHistoryProvider", () {
    test("should add entry successfully", () async {
      // Arrange
      final entry = TaskHistoryEntry(
        id: "uuid",
        taskId: "taskId",
        timestamp: DateTime(2026, 9, 2, 8, 0),
        toStatus: .inProgress,
      );

      when(() => mockCrashReporter.log(any())).thenAnswer((_) {});
      when(
        () => mockCrashReporter.setCustomKey(any(), any()),
      ).thenAnswer((_) async {});
      when(
        () => mockTaskDetailRepository.addEntry(entry),
      ).thenAnswer((_) async {});

      // Act
      await container.read(taskDetailsHistoryProvider.notifier).addEntry(entry);

      // Assert
      verify(() => mockCrashReporter.log(any())).called(1);
      verify(() => mockCrashReporter.setCustomKey(any(), any())).called(2);
      verify(() => mockTaskDetailRepository.addEntry(entry)).called(1);
    });

    test(
      "should delete task entries successfully by passing a task id",
      () async {
        // Arrange
        const taskId = "taskId";
        final entries = populateEntries();
        final entryIdsToDelete = entries.map((e) => e.id).toList();

        when(
          () => mockTaskDetailRepository.getHistoryEntriesByTaskId(taskId),
        ).thenReturn(entries);

        when(
          () => mockTaskDetailRepository.deleteTaskIdEntries(entryIdsToDelete),
        ).thenAnswer((_) async {});

        // Act
        await container
            .read(taskDetailsHistoryProvider.notifier)
            .deleteTaskEntries(taskId);

        // Assert
        verify(
          () => mockTaskDetailRepository.getHistoryEntriesByTaskId(taskId),
        ).called(1);
        verify(
          () => mockTaskDetailRepository.deleteTaskIdEntries(entryIdsToDelete),
        ).called(1);
      },
    );
  });
}

List<TaskHistoryEntry> populateEntries() {
  return [
    TaskHistoryEntry(
      id: "uuid",
      taskId: "taskId",
      timestamp: DateTime(2026, 9, 2, 8, 0),
      toStatus: .inProgress,
    ),
    TaskHistoryEntry(
      id: "uuid",
      taskId: "taskId2",
      timestamp: DateTime(2026, 9, 2, 8, 2),
      toStatus: .paused,
    ),
    TaskHistoryEntry(
      id: "uuid",
      taskId: "taskId",
      timestamp: DateTime(2026, 9, 2, 8, 3),
      toStatus: .inProgress,
    ),
    TaskHistoryEntry(
      id: "uuid",
      taskId: "taskId3",
      timestamp: DateTime(2026, 9, 2, 9, 0),
      toStatus: .completed,
    ),
  ];
}
