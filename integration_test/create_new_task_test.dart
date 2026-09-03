import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focus_box/main.dart';
import 'package:integration_test/integration_test.dart';

import 'utils/third_party_plugins.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await setupThirdPartyDependencies();

  testWidgets("create new task for today and load it on home", (tester) async {
    // Arrange
    const newTaskName = "Test task";

    await tester.pumpWidget(const MyApp());

    // Act
    await tester.tap(find.byKey(const Key("addNewTaskBtn")));
    await tester.pumpAndSettle();

    final taskNameField = find.byKey(const Key("taskNameField"));
    // No need to focus the field through a tester.tap since the focus
    // is there by default
    await tester.enterText(taskNameField, newTaskName);

    final timeTotalHsField = find.byKey(const Key("timeTotalHsField"));
    await tester.tap(timeTotalHsField); // Focus that field
    await tester.enterText(timeTotalHsField, "1");

    final timeTotalMinsField = find.byKey(const Key("timeTotalMinsField"));
    await tester.tap(timeTotalMinsField); // Focus that field
    await tester.enterText(timeTotalMinsField, "0");

    final saveButton = find.byKey(const Key("newTaskSaveBtn"));
    await tester.tap(saveButton);

    await tester.pumpAndSettle();

    // Assert

    // Ensure that the new task is loaded on home
    // (after having dismissed the bottom sheet)
    expect(find.text(newTaskName), findsOne);
  });

  testWidgets("create new task for tomorrow and load it on home", (
    tester,
  ) async {
    // Arrange
    const newTaskName = "Test task";
    final tomorrowDayNum = DateTime.now().add(const Duration(days: 1)).day;

    await tester.pumpWidget(const MyApp());

    // Act
    await tester.tap(find.byKey(const Key("addNewTaskBtn")));
    await tester.pumpAndSettle();

    final taskNameField = find.byKey(const Key("taskNameField"));
    // No need to focus the field through a tester.tap since the focus
    // is there by default
    await tester.enterText(taskNameField, newTaskName);

    final timeTotalHsField = find.byKey(const Key("timeTotalHsField"));
    await tester.tap(timeTotalHsField); // Focus that field
    await tester.enterText(timeTotalHsField, "1");

    final timeTotalMinsField = find.byKey(const Key("timeTotalMinsField"));
    await tester.tap(timeTotalMinsField); // Focus that field
    await tester.enterText(timeTotalMinsField, "0");

    final dayToDoTaskField = find.byKey(const Key("dayToDoTaskField"));
    await tester.tap(dayToDoTaskField);
    await tester.pump();
    // Calendar is shown
    await tester.tap(find.text("$tomorrowDayNum"));
    await tester.tap(find.text("OK")); // Close the calendar
    await tester.pump();

    final saveButton = find.byKey(const Key("newTaskSaveBtn"));
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    // Assert

    // Ensure that the new task is not loaded on home
    // (after having dismissed the bottom sheet) given that
    // the default selected day is today, and the created task
    // has been assigned to tomorrow
    expect(find.text(newTaskName), findsNothing);

    // Tap on text field in order to show the calendar
    final homeFilterDateField = find.byKey(const Key("homeFilterDateField"));
    await tester.tap(homeFilterDateField);
    await tester.pump();

    // Select tomorrow
    final tomorrowDayNumFinder = find.text("$tomorrowDayNum");
    await tester.tap(tomorrowDayNumFinder);

    // Click "Ok" and dismiss calendar
    await tester.tap(find.text("OK"));
    await tester.pump();

    // Ensure that the new task is loaded on home
    // given that the selected day is now tomorrow, and
    // the created task has been assigned to tomorrow
    expect(find.text(newTaskName), findsOne);
  });
}
