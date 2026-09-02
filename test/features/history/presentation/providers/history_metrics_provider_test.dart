import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focus_box/core/domain/entities/task.dart';
import 'package:focus_box/core/managers/crash_reporter.dart';
import 'package:focus_box/features/history/domain/entities/history_metric.dart';
import 'package:focus_box/features/history/presentation/providers/history_metrics_provider.dart';
import 'package:focus_box/features/task_details/domain/entities/task_history_entry.dart';
import 'package:mocktail/mocktail.dart';

class MockCrashReporter extends Mock implements CrashReporter {}

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
