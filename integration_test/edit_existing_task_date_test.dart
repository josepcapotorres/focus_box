import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focus_box/core/data/models/task_model.dart';
import 'package:focus_box/main.dart';
import 'package:hive/hive.dart';

import 'utils/third_party_plugins.dart';

void main() async {
  await setupThirdPartyDependencies();

  testWidgets("should change the day of the existing task", (tester) async {
    // Arrange
    // We need an existing task on the db in order
    // to operate on this task
    const taskId = "uuid";
    const taskName = "Test task";
    final tomorrowDayNumber = DateTime.now().add(const Duration(days: 1)).day;

    await insertATaskInLocalDb(taskName);

    await tester.pumpWidget(const MyApp());
    // Wait until the Stream loads the inserted task on screen.ç
    // Otherwise, the key "homeTaskItem-..." won't be found
    await tester.pumpAndSettle();

    // Assert
    // New task is loaded on screen for today
    expect(find.text(taskName), findsOne);

    // Act
    final homeTaskItem = find.byKey(const Key("homeTaskItem-$taskId"));
    await tester.tap(homeTaskItem);
    await tester.pumpAndSettle();

    final taskDetailsEditBtn = find.byKey(const Key("taskDetailsEditBtn"));
    await tester.tap(taskDetailsEditBtn);
    await tester.pumpAndSettle();

    final dayToDoTaskField = find.byKey(const Key("dayToDoTaskField"));
    await tester.tap(dayToDoTaskField);
    await tester.pump();
    // Calendar popup is shown at this point
    final dayToSelect = find.text("$tomorrowDayNumber");
    await tester.tap(dayToSelect);
    await tester.tap(find.text("OK"));
    await tester.pump();

    final saveButton = find.byKey(const Key("newTaskSaveBtn"));
    await tester.tap(saveButton);
    await tester.pumpAndSettle();
    // We are currently in the task details page with the bottom sheet dismissed
    final backButton = find.backButton();
    await tester.tap(backButton);
    await tester.pumpAndSettle();
    // We have been navigated back to the home page at this point

    // Assert
    // New task is assigned to tomorrow. So, it's not loaded currently,
    // since by default, the selected date is today.
    expect(find.text(taskName), findsNothing);
  });
}

Future<void> insertATaskInLocalDb(String taskName) async {
  final box = await Hive.openBox("tasks");

  // Ensure that there is no register in that box before adding one
  await box.clear();

  // Insert a task
  final taskModel = TaskModel(
    "uuid",
    taskName,
    .pending,
    .zero,
    const Duration(hours: 1),
    DateTime.now(),
    null,
  );

  await box.put(taskModel.id, taskModel.toJson());
}
