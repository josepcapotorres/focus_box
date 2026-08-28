import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focus_box/core/data/models/task_model.dart';
import 'package:focus_box/core/domain/entities/task.dart';
import 'package:focus_box/core/domain/enums/task_status.dart';
import 'package:focus_box/core/managers/crash_reporter.dart';
import 'package:focus_box/core/providers/ticker_provider.dart';
import 'package:focus_box/features/focus_mode/domain/entities/focus_session_entity.dart';
import 'package:focus_box/features/focus_mode/presentation/providers/focus_session_provider.dart';
import 'package:focus_box/features/home/domain/repositories/home_repository.dart';
import 'package:focus_box/features/task_details/data/repositories/task_details_repository.dart';
import 'package:focus_box/features/task_details/data/repositories/task_details_repository_impl.dart';
import 'package:focus_box/features/task_details/domain/entities/task_history_entry.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

class MockCrashReporter extends Mock implements CrashReporter {}

class MockHomeRepository extends Mock implements HomeRepository {}

class MockTaskDetailsRepository extends Mock implements TaskDetailsRepository {}

class FakeTaskHistoryEntry extends Fake implements TaskHistoryEntry {}

class FakeTaskModel extends Fake implements TaskModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockCrashReporter mockCrashReporter;
  late MockHomeRepository mockHomeRepository;
  late MockTaskDetailsRepository mockTaskDetailsRepository;
  late ProviderContainer providerContainer;

  setUpAll(() {
    registerFallbackValue("");
    registerFallbackValue(FakeTaskHistoryEntry());
    registerFallbackValue(FakeTaskModel());
  });

  setUp(() {
    mockCrashReporter = MockCrashReporter();
    mockHomeRepository = MockHomeRepository();
    mockTaskDetailsRepository = MockTaskDetailsRepository();
    providerContainer = ProviderContainer.test(
      overrides: [
        crashReporterProvider.overrideWithValue(mockCrashReporter),
        homeRepositoryProvider.overrideWithValue(AsyncData(mockHomeRepository)),
        taskDetailsRepositoryProvider.overrideWithValue(
          AsyncData(mockTaskDetailsRepository),
        ),
      ],
    );
  });

  test("should have a null value by default", () async {
    // Act
    final initialValue = providerContainer.read(focusSessionProvider);

    // Assert
    expect(initialValue, isNull);
  });

  test(
    "should start an in-progress task by loading time to resume timer and persist it with its existing time",
    () async {
      // Arrange
      final mockTaskId = const Uuid().v4();
      final mockTask = populateBaseTask(mockTaskId, .inProgress);

      final mockTaskModel = TaskModel.fromEntity(mockTask);

      arrangeCommonMocks(
        mockHomeRepository,
        mockCrashReporter,
        mockTaskDetailsRepository,
      );

      // Act
      await providerContainer
          .read(focusSessionProvider.notifier)
          .startTask(mockTask);

      // Assert
      verify(() => mockHomeRepository.saveOrEditTask(mockTaskModel)).called(1);

      final capturedEntry =
          verify(
                () => mockTaskDetailsRepository.addEntry(captureAny()),
              ).captured.single
              as TaskHistoryEntry;

      expect(capturedEntry.toStatus, TaskStatus.inProgress);
      expect(providerContainer.read(tickerProvider).inMinutes, 2);
      expect(
        providerContainer.read(focusSessionProvider),
        FocusSessionEntity(taskId: mockTaskId, status: .inProgress),
      );
    },
  );

  test(
    "should pause the current in-progress task before starting the selected task",
    () async {
      // Arrange
      final inProgressTaskUuid = const Uuid().v4();
      final inProgressTask = populateBaseTask(inProgressTaskUuid, .pending);

      final selectedTaskToStartUuid = const Uuid().v4();
      final selectedTaskToStart = populateBaseTask(
        selectedTaskToStartUuid,
        .paused,
      );

      arrangeCommonMocks(
        mockHomeRepository,
        mockCrashReporter,
        mockTaskDetailsRepository,
      );

      // Act
      // Simulate the previous started task (status inProgress)
      await providerContainer
          .read(focusSessionProvider.notifier)
          .startTask(inProgressTask);

      // Assert
      expect(
        providerContainer.read(focusSessionProvider),
        FocusSessionEntity(taskId: inProgressTaskUuid, status: .inProgress),
      );

      // Act
      // Start another task while one is already in progress.
      await providerContainer
          .read(focusSessionProvider.notifier)
          .startTask(selectedTaskToStart);

      // Assert
      expect(
        providerContainer.read(focusSessionProvider),
        FocusSessionEntity(
          taskId: selectedTaskToStartUuid,
          status: .inProgress,
        ),
      );
    },
  );
}

Task populateBaseTask(String uuid, TaskStatus status) {
  return Task(
    uuid,
    "taskName",
    status,
    const Duration(minutes: 2),
    const Duration(minutes: 5),
    DateTime.now(),
    null,
  );
}

void arrangeCommonMocks(
  MockHomeRepository mockHomeRepository,
  MockCrashReporter mockCrashReporter,
  MockTaskDetailsRepository mockTaskDetailsRepository,
) {
  when(() => mockHomeRepository.saveOrEditTask(any())).thenAnswer((_) async {});

  when(
    () => mockCrashReporter.setCustomKey(any(), any()),
  ).thenAnswer((_) async {});

  when(
    () => mockTaskDetailsRepository.addEntry(any()),
  ).thenAnswer((_) async {});
}
