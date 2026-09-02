import 'package:clock/clock.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focus_box/core/extensions/datetime_extension.dart';
import 'package:focus_box/core/managers/crash_reporter.dart';
import 'package:focus_box/features/history/presentation/providers/history_current_filter_provider.dart';
import 'package:focus_box/features/history/presentation/providers/history_date_ranges_filter_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockCrashReporter extends Mock implements CrashReporter {}

void main() {
  late MockCrashReporter mockCrashReporter;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue("");
    mockCrashReporter = MockCrashReporter();
    container = ProviderContainer.test(
      overrides: [crashReporterProvider.overrideWithValue(mockCrashReporter)],
    );
  });

  test("should return today DateTime values for .today use case", () async {
    // It simulates the DateTime.now() that's inside
    // historyRateRangesFilterProvider
    final mockToday = DateTime.now();

    await withClock(Clock.fixed(mockToday), () async {
      // Arrange
      arrangeMocks(mockCrashReporter);

      // Act
      container
          .read(historyCurrentFilterProvider.notifier)
          .setCurrentFilter(.today);

      final result = container.read(historyRateRangesFilterProvider);

      // Assert
      expect(
        (result.$1.toDateOnly, result.$2.toDateOnly),
        (mockToday.toDateOnly, mockToday.toDateOnly),
      );
    });
  });

  test(
    "should return from first day of week to last day of week DateTime values for .currentWeek use case",
    () async {
      // It simulates the DateTime.now() that's inside
      // historyRateRangesFilterProvider
      final mockToday = DateTime.now();

      await withClock(Clock.fixed(mockToday), () async {
        // Arrange
        arrangeMocks(mockCrashReporter);

        // Act
        container
            .read(historyCurrentFilterProvider.notifier)
            .setCurrentFilter(.currentWeek);

        final result = container.read(historyRateRangesFilterProvider);

        // Assert
        expect(
          (result.$1.toDateOnly, result.$2.toDateOnly),
          (
            mockToday.getFirstDayOfCurrentWeek().toDateOnly,
            mockToday.getLastDayOfCurrentWeek().toDateOnly,
          ),
        );
      });
    },
  );

  test(
    "should return from first day of month to last day of month DateTime values for .currentMonth use case",
    () async {
      // It simulates the DateTime.now() that's inside
      // historyRateRangesFilterProvider
      final mockToday = DateTime.now();

      await withClock(Clock.fixed(mockToday), () async {
        // Arrange
        arrangeMocks(mockCrashReporter);

        // Act
        container
            .read(historyCurrentFilterProvider.notifier)
            .setCurrentFilter(.currentMonth);

        final result = container.read(historyRateRangesFilterProvider);

        // Assert
        expect(
          (result.$1.toDateOnly, result.$2.toDateOnly),
          (
            mockToday.getFirstDayOfCurrentMonth().toDateOnly,
            mockToday.getLastDayOfCurrentMonth().toDateOnly,
          ),
        );
      });
    },
  );
}

void arrangeMocks(MockCrashReporter mockCrashReporter) {
  when(() => mockCrashReporter.log(any())).thenAnswer((_) async {});

  when(
    () => mockCrashReporter.setCustomKey(any(), any()),
  ).thenAnswer((_) async {});
}
