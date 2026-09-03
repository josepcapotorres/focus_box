import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focus_box/firebase_options.dart';
import 'package:focus_box/main.dart';
import 'package:hive/hive.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await setupThirdPartyDependencies();

  testWidgets("create new task and load it on home", (tester) async {
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
}

Future<void> setupThirdPartyDependencies() async {
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
