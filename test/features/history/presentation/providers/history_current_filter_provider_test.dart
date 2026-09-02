import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focus_box/features/history/domain/enums/history_range_enum.dart';
import 'package:focus_box/features/history/presentation/providers/history_current_filter_provider.dart';

void main() {
  late ProviderContainer container;

  setUpAll(() {
    container = ProviderContainer.test();
  });

  test("should return .today as initial state", () async {
    // Arrange
    const initialState = HistoryRange.today;

    // Act
    final state = container.read(historyCurrentFilterProvider);

    // Assert
    expect(state, initialState);
  });

  test("should set currentFilter as .currentWeek", () async {
    // Arrange
    const initialState = HistoryRange.currentWeek;

    // Act
    container
        .read(historyCurrentFilterProvider.notifier)
        .setCurrentFilter(.currentWeek);

    final state = container.read(historyCurrentFilterProvider);

    // Assert
    expect(state, initialState);
  });
}
