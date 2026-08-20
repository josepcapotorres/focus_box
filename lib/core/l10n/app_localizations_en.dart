// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get commonNoResults => 'No results';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get homeTitle => 'FocusBox';

  @override
  String get homeToday => 'Today';

  @override
  String get homeTomorrow => 'Tomorrow';

  @override
  String homeTodayLabel(String date) {
    return 'Today, $date';
  }

  @override
  String get homeListError => 'Error on fetching today tasks';

  @override
  String get homeHistorical => 'Historical data';

  @override
  String get saveEditTaskNewTaskTitle => 'New task';

  @override
  String get saveEditTaskEditTaskTitle => 'Edit task';

  @override
  String get saveEditTaskTaskName => 'Task name';

  @override
  String get saveEditTaskTimeEstimated => 'Estimated time';

  @override
  String get saveEditTaskAssignDay => 'Day assignment';
}
