import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focus_box/core/extensions/datetime_extension.dart';
import 'package:focus_box/features/home/presentation/providers/home_selected_date_filter.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer.test();
  });

  test("should return the current date by default", () async {
    // Act
    final initialState = container.read(homeSelectedDateFilterProvider);

    // Assert
    // I avoid a test failing always, given that DateTime.now()
    // gets even the milliseconds
    expect(initialState.toDateOnly, DateTime.now().toDateOnly);
  });

  test("should update the passed value", () async {
    // Arrange
    final dateTime = DateTime(2026, 9, 1);

    // Act
    container.read(homeSelectedDateFilterProvider.notifier).setDate(dateTime);
    final newValue = container.read(homeSelectedDateFilterProvider);

    // Assert
    expect(newValue, dateTime);
  });
}
