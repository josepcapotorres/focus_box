import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focus_box/core/domain/entities/task.dart';
import 'package:focus_box/core/domain/enums/task_status.dart';
import 'package:focus_box/core/managers/crash_reporter.dart';
import 'package:focus_box/features/home/domain/repositories/home_repository.dart';
import 'package:focus_box/features/home/presentation/providers/home_selected_date_filter.dart';
import 'package:focus_box/features/home/presentation/providers/home_tasks_provider.dart';
import 'package:focus_box/features/task_details/data/repositories/task_details_repository.dart';
import 'package:focus_box/features/task_details/data/repositories/task_details_repository_impl.dart';
import 'package:focus_box/features/task_details/domain/entities/task_history_entry.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

class MockTaskDetailsRepository extends Mock implements TaskDetailsRepository {}

class MockCrashReporter extends Mock implements CrashReporter {}

class FakeTaskHistoryEntry extends Fake implements TaskHistoryEntry {}

class FakeTask extends Fake implements Task {}

void main() {
  late MockHomeRepository mockHomeRepository;
  late MockTaskDetailsRepository mockTaskDetailsRepository;
  late MockCrashReporter mockCrashReporter;
  late ProviderContainer container;
  late List<Override> overrides;

  setUpAll(() {
    registerFallbackValue("");
    registerFallbackValue(FakeTaskHistoryEntry());
    registerFallbackValue(FakeTask());
  });

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    mockTaskDetailsRepository = MockTaskDetailsRepository();
    mockCrashReporter = MockCrashReporter();
    overrides = [
      homeRepositoryProvider.overrideWithValue(AsyncData(mockHomeRepository)),
      taskDetailsRepositoryProvider.overrideWithValue(
        AsyncData(mockTaskDetailsRepository),
      ),
      crashReporterProvider.overrideWithValue(mockCrashReporter),
    ];
    container = ProviderContainer.test(overrides: overrides);
  });

  group("homeTasksProvider", () {
    test("should emit Task instances", () async {
      // Arrange
      final task = populateTask();
      when(
        () => mockHomeRepository.getInterruptedTask(),
      ).thenAnswer((_) async => null);
      when(
        () => mockHomeRepository.saveOrEditTask(task),
      ).thenAnswer((_) async {});
      when(
        () => mockTaskDetailsRepository.addEntry(any()),
      ).thenAnswer((_) async {});
      when(
        () => mockCrashReporter.setCustomKey(any(), any()),
      ).thenAnswer((_) async {});

      when(
        () => mockHomeRepository.watchTasks(),
      ).thenAnswer((_) => Stream.value([task]));

      // Act
      int count = 0;

      final subscription = container.listen(homeTasksProvider, (_, next) {
        count++;
      });

      await container.read(homeTasksProvider.future);

      // Assert
      expect(count, 1);
      subscription.close();
    });

    test("should update passed value to the list of tasks", () async {
      // Arrange
      final task = populateTask();
      final updatedTask = task.copyWith(status: .inProgress);

      final container = ProviderContainer.test(
        overrides: [
          ...overrides,
          recoverInterruptedSessionProvider.overrideWithValue(
            const AsyncValue.data({}),
          ),
        ],
      );

      when(() => mockHomeRepository.watchTasks()).thenAnswer((_) {
        return Stream.value([task]);
      });

      // Act
      final subscription = container.listen(homeTasksProvider, (_, _) {});
      final tasks = await container.read(homeTasksProvider.future);

      // Assert
      expect(tasks.length, 1);
      expect(tasks.first.status, TaskStatus.pending);

      // Act
      container.read(homeTasksProvider.notifier).updateTask(updatedTask);
      final updatedTasks = await container.read(homeTasksProvider.future);

      // Assert
      expect(updatedTasks.length, 1);
      expect(updatedTasks.first.status, TaskStatus.inProgress);

      subscription.close();
    });
  });

  group("currentTaskProvider", () {
    test(
      "should return a Task instance to be found taskId in tasks list",
      () async {
        // Arrange
        const taskId = "taskId";

        final task = Task(
          taskId,
          "task 1",
          .pending,
          .zero,
          .zero,
          DateTime.now(),
          null,
        );

        when(() => mockHomeRepository.watchTasks()).thenAnswer((_) {
          return Stream.value([task]);
        });

        final container = ProviderContainer.test(
          overrides: [
            ...overrides,
            recoverInterruptedSessionProvider.overrideWithValue(
              const AsyncValue.data({}),
            ),
          ],
        );

        // Act
        final subscription = container.listen(homeTasksProvider, (_, _) {});

        await container.read(homeTasksProvider.future);
        final currentTask = container.read(currentTaskProvider(taskId));

        // Assert
        expect(currentTask, isNotNull);
        expect(currentTask?.id, taskId);

        subscription.close();
      },
    );

    test(
      "should return a null Task instance given taskId isn't found in tasks list",
      () async {
        // Arrange
        const taskId = "taskId";
        const wrongTaskId = "wrongTaskId";

        final task = Task(
          taskId,
          "task 1",
          .pending,
          .zero,
          .zero,
          DateTime.now(),
          null,
        );

        when(() => mockHomeRepository.watchTasks()).thenAnswer((_) {
          return Stream.value([task]);
        });

        final container = ProviderContainer.test(
          overrides: [
            ...overrides,
            recoverInterruptedSessionProvider.overrideWithValue(
              const AsyncValue.data({}),
            ),
          ],
        );

        // Act
        final subscription = container.listen(homeTasksProvider, (_, _) {});

        await container.read(homeTasksProvider.future);
        final currentTask = container.read(currentTaskProvider(wrongTaskId));

        // Assert
        expect(currentTask, isNull);

        subscription.close();
      },
    );
  });

  group("homeFilteredTasksProvider", () {
    test("should filter and return at least one item in the list", () async {
      // Arrange
      final task = populateTask();

      final container = ProviderContainer.test(
        overrides: [
          ...overrides,
          homeSelectedDateFilterProvider.overrideWithValue(DateTime.now()),
          recoverInterruptedSessionProvider.overrideWithValue(
            const AsyncValue.data({}),
          ),
        ],
      );

      when(() => mockHomeRepository.watchTasks()).thenAnswer((_) {
        return Stream.value([task]);
      });

      final subscription = container.listen(homeTasksProvider, (_, _) {});

      // Act
      final tasks = await container.read(homeTasksProvider.future);

      // Assert
      expect(tasks.length, 1);

      subscription.close();
    });

    test(
      "should filter and return an empty list since no results found for provided date",
      () async {
        // Arrange
        final container = ProviderContainer.test(
          overrides: [
            ...overrides,
            homeSelectedDateFilterProvider.overrideWithValue(
              DateTime(2026, 8, 31),
            ),
            recoverInterruptedSessionProvider.overrideWithValue(
              const AsyncValue.data({}),
            ),
          ],
        );

        when(() => mockHomeRepository.watchTasks()).thenAnswer((_) {
          return Stream.value([]);
        });

        final subscription = container.listen(homeTasksProvider, (_, _) {});

        // Act
        final tasks = await container.read(homeTasksProvider.future);

        // Assert
        expect(tasks, isEmpty);

        subscription.close();
      },
    );
  });

  group("recoverInterruptedSessionProvider", () {
    test(
      "should not call saveOrEditTask and addEntry if no interruptedTask has been found",
      () async {
        // Arrange
        when(
          () => mockHomeRepository.getInterruptedTask(),
        ).thenAnswer((_) async => null);

        final container = ProviderContainer.test(
          overrides: [
            ...overrides,
            recoverInterruptedSessionProvider.overrideWithValue(
              const AsyncValue.data({}),
            ),
          ],
        );

        // Act
        await container.read(recoverInterruptedSessionProvider.future);

        // Assert
        verifyNever(() => mockHomeRepository.saveOrEditTask(any()));
        verifyNever(() => mockTaskDetailsRepository.addEntry(any()));
      },
    );

    test(
      "should call saveOrEditTask and addEntry if interruptedTask has been found",
      () async {
        // Define a fixed date to freeze DateTime.now() during the test
        final fixedNow = DateTime(2026, 9, 1, 12, 0, 0);

        await withClock(Clock.fixed(fixedNow), () async {
          // Arrange
          final startedAt = DateTime(2026, 9, 1);
          final task = populateTask().copyWith(startedAt: startedAt);

          when(
            () => mockHomeRepository.getInterruptedTask(),
          ).thenAnswer((_) async => task);

          when(
            () => mockHomeRepository.saveOrEditTask(any()),
          ).thenAnswer((_) async {});

          when(
            () => mockTaskDetailsRepository.addEntry(any()),
          ).thenAnswer((_) async {});

          when(
            () => mockCrashReporter.setCustomKey(any(), any()),
          ).thenAnswer((_) async {});

          // Act
          await container.read(recoverInterruptedSessionProvider.future);

          // Assert
          verify(() => mockHomeRepository.getInterruptedTask()).called(1);
          verify(() => mockHomeRepository.saveOrEditTask(any())).called(1);
          verify(() => mockTaskDetailsRepository.addEntry(any())).called(1);
        });
      },
    );
  });
}

Task populateTask() {
  return Task(
    const Uuid().v4(),
    "task 1",
    .pending,
    .zero,
    .zero,
    DateTime.now(),
    null,
  );
}
