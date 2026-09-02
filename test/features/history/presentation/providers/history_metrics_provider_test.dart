import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focus_box/core/domain/entities/task.dart';
import 'package:focus_box/core/managers/crash_reporter.dart';
import 'package:focus_box/features/history/domain/entities/history_metric.dart';
import 'package:focus_box/features/history/presentation/providers/history_date_ranges_filter_provider.dart';
import 'package:focus_box/features/history/presentation/providers/history_metrics_provider.dart';
import 'package:focus_box/features/home/domain/repositories/home_repository.dart';
import 'package:focus_box/features/home/presentation/providers/home_tasks_provider.dart';
import 'package:focus_box/features/task_details/domain/entities/task_history_entry.dart';
import 'package:mocktail/mocktail.dart';

class MockCrashReporter extends Mock implements CrashReporter {}

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late MockCrashReporter mockCrashReporter;

  setUpAll(() {
    registerFallbackValue("");
  });

  setUp(() {
    mockCrashReporter = MockCrashReporter();
  });

  group("historyMetricsProvider", () {
    test(
      "should return proper data for empty task list and filled entries list",
      () async {
        // Arrange
        final tasks = <Task>[];
        final entries = populateEntries();

        arrangeCrashReports(mockCrashReporter);

        final container = ProviderContainer.test(
          overrides: [
            crashReporterProvider.overrideWithValue(mockCrashReporter),
            historyTasksBetweenSelectedDateRangeProvider.overrideWithValue(
              AsyncData(tasks),
            ),
            historyEntriesBetweenSelectedDateRangeProvider.overrideWithValue(
              AsyncData(entries),
            ),
          ],
        );

        // Act
        final metrics = await container.read(historyMetricsProvider.future);

        // Assert
        verify(() => mockCrashReporter.log(any())).called(1);
        verify(() => mockCrashReporter.setCustomKey(any(), any())).called(2);

        expect(
          metrics,
          const HistoryMetric(Duration(minutes: 59), Duration.zero, 0),
        );
      },
    );

    test(
      "should return proper data for filled task list and empty entries list",
      () async {
        // Arrange
        final entries = <TaskHistoryEntry>[];
        final tasks = populateTasks();

        arrangeCrashReports(mockCrashReporter);

        final container = ProviderContainer.test(
          overrides: [
            crashReporterProvider.overrideWithValue(mockCrashReporter),
            historyTasksBetweenSelectedDateRangeProvider.overrideWithValue(
              AsyncData(tasks),
            ),
            historyEntriesBetweenSelectedDateRangeProvider.overrideWithValue(
              AsyncData(entries),
            ),
          ],
        );

        // Act
        final metrics = await container.read(historyMetricsProvider.future);

        // Assert
        verify(() => mockCrashReporter.log(any())).called(1);
        verify(() => mockCrashReporter.setCustomKey(any(), any())).called(2);

        expect(
          metrics,
          const HistoryMetric(
            Duration.zero,
            Duration(hours: 2, minutes: 15),
            0,
          ),
        );
      },
    );

    test(
      "should return proper data for empty task list and empty entries list",
      () async {
        // Arrange
        final entries = <TaskHistoryEntry>[];
        final tasks = <Task>[];

        when(() => mockCrashReporter.log(any())).thenAnswer((_) {});

        when(
          () => mockCrashReporter.setCustomKey(any(), any()),
        ).thenAnswer((_) async {});

        final container = ProviderContainer.test(
          overrides: [
            crashReporterProvider.overrideWithValue(mockCrashReporter),
            historyTasksBetweenSelectedDateRangeProvider.overrideWithValue(
              AsyncData(tasks),
            ),
            historyEntriesBetweenSelectedDateRangeProvider.overrideWithValue(
              AsyncData(entries),
            ),
          ],
        );

        // Act
        final metrics = await container.read(historyMetricsProvider.future);

        // Assert
        verify(() => mockCrashReporter.log(any())).called(1);
        verify(() => mockCrashReporter.setCustomKey(any(), any())).called(2);

        expect(metrics, const HistoryMetric(Duration.zero, Duration.zero, 0));
      },
    );

    test(
      "should return proper data for filled task list and filled entries list",
      () async {
        // Arrange
        final entries = populateEntries();
        final tasks = populateTasks();

        when(() => mockCrashReporter.log(any())).thenAnswer((_) {});

        when(
          () => mockCrashReporter.setCustomKey(any(), any()),
        ).thenAnswer((_) async {});

        final container = ProviderContainer.test(
          overrides: [
            crashReporterProvider.overrideWithValue(mockCrashReporter),
            historyTasksBetweenSelectedDateRangeProvider.overrideWithValue(
              AsyncData(tasks),
            ),
            historyEntriesBetweenSelectedDateRangeProvider.overrideWithValue(
              AsyncData(entries),
            ),
          ],
        );

        // Act
        final metrics = await container.read(historyMetricsProvider.future);

        // Assert
        verify(() => mockCrashReporter.log(any())).called(1);
        verify(() => mockCrashReporter.setCustomKey(any(), any())).called(2);

        expect(
          metrics,
          const HistoryMetric(
            Duration(minutes: 59),
            Duration(hours: 2, minutes: 15),
            43,
          ),
        );
      },
    );
  });

  group("historyTasksBetweenSelectedDateRangeProvider", () {
    test("should return empty entries when task list is empty", () async {
      // Arrange
      final dateTime = DateTime.now();

      final container = ProviderContainer.test(
        overrides: [
          crashReporterProvider.overrideWithValue(mockCrashReporter),
          homeTasksProvider.overrideWithBuild((_, _) => Stream.value([])),
          historyRateRangesFilterProvider.overrideWithValue((
            dateTime,
            dateTime,
          )),
        ],
      );

      arrangeCrashReports(mockCrashReporter);

      // Act
      final entries = await container.read(
        historyTasksBetweenSelectedDateRangeProvider.future,
      );

      // Assert
      verify(() => mockCrashReporter.log(any())).called(3);
      verify(() => mockCrashReporter.setCustomKey(any(), any())).called(2);

      expect(entries, isEmpty);
    });

    test("should return empty entries when task list is filled", () async {
      // Arrange
      final dateTime = DateTime.now();

      final container = ProviderContainer.test(
        overrides: [
          crashReporterProvider.overrideWithValue(mockCrashReporter),
          homeTasksProvider.overrideWithBuild(
            (_, _) => Stream.value(populateTasks()),
          ),
          historyRateRangesFilterProvider.overrideWithValue((
            dateTime,
            dateTime,
          )),
        ],
      );

      arrangeCrashReports(mockCrashReporter);

      // Act
      final entries = await container.read(
        historyTasksBetweenSelectedDateRangeProvider.future,
      );

      // Assert
      verify(() => mockCrashReporter.log(any())).called(3);
      verify(() => mockCrashReporter.setCustomKey(any(), any())).called(2);

      expect(entries, isEmpty);
    });

    test("should return filled entries when task list is filled", () async {
      // Arrange
      final dateTime = DateTime.now();
      final mockHomeRepository = MockHomeRepository();
      final tasks = populateTasks();

      final container = ProviderContainer.test(
        overrides: [
          crashReporterProvider.overrideWithValue(mockCrashReporter),
          homeRepositoryProvider.overrideWithValue(
            AsyncData(mockHomeRepository),
          ),
          recoverInterruptedSessionProvider.overrideWithValue(
            const AsyncData({}),
          ),
          historyRateRangesFilterProvider.overrideWithValue((
            dateTime,
            dateTime,
          )),
        ],
      );

      arrangeCrashReports(mockCrashReporter);

      final tasksController = StreamController<List<Task>>();

      when(
        () => mockHomeRepository.watchTasks(),
      ).thenAnswer((_) => tasksController.stream);

      // Act
      final subscription = container.listen(homeTasksProvider, (_, _) {});

      tasksController.add(tasks);

      // Wait until the event queue process the stream.
      // It's necessary. Otherwise, the test fails
      await pumpEventQueue();

      final entries = await container.read(
        historyTasksBetweenSelectedDateRangeProvider.future,
      );

      // Assert
      verify(() => mockCrashReporter.log(any())).called(3);
      verify(() => mockCrashReporter.setCustomKey(any(), any())).called(2);
      verify(() => mockHomeRepository.watchTasks()).called(1);

      expect(entries, isNotEmpty);

      // Cleanup
      tasksController.close();
      subscription.close();
    });
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
      taskId: "taskId",
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
      taskId: "taskId",
      timestamp: DateTime(2026, 9, 2, 9, 0),
      toStatus: .completed,
    ),
  ];
}

List<Task> populateTasks() {
  return [
    Task(
      "uuid",
      "task 1",
      .pending,
      const Duration(hours: 1, minutes: 30),
      const Duration(hours: 1, minutes: 30),
      DateTime.now(),
      null,
    ),
    Task(
      "uuid",
      "task 1",
      .pending,
      const Duration(hours: 0, minutes: 30),
      const Duration(hours: 0, minutes: 45),
      DateTime.now(),
      null,
    ),
  ];
}

void arrangeCrashReports(MockCrashReporter mockCrashReporter) {
  when(() => mockCrashReporter.log(any())).thenAnswer((_) {});

  when(
    () => mockCrashReporter.setCustomKey(any(), any()),
  ).thenAnswer((_) async {});
}
