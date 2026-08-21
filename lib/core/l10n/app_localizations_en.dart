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
  String get commonTaskInProgress => 'In progress';

  @override
  String get commonTaskCompleted => 'Completed';

  @override
  String get commonTaskPaused => 'Paused';

  @override
  String get commonTaskExceeded => 'Exceeded';

  @override
  String get commonTaskPending => 'Pending';

  @override
  String get commonNo => 'No';

  @override
  String get commonYes => 'Yes';

  @override
  String get homeTitle => 'FocusBox';

  @override
  String get homeViewSelectedDateTask => 'View tasks for the selected date';

  @override
  String get homeToday => 'Today';

  @override
  String get homeListError => 'Error on fetching today tasks';

  @override
  String get homeHistorical => 'Historical data';

  @override
  String homeMinsLeft(String mins) {
    return '$mins minutes left';
  }

  @override
  String homeMinsExceeded(String mins) {
    return ' · +$mins min exceeded';
  }

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

  @override
  String get taskDetailsTitle => 'Task details';

  @override
  String get taskDetailsTaskNotFound => 'Task not found';

  @override
  String get taskDetailsEstimatedTime => 'Estimated time';

  @override
  String get taskDetailsRealTime => 'Real time';

  @override
  String get taskDetailsDifference => 'Difference';

  @override
  String get taskDetailsTimeline => 'Timeline';

  @override
  String get taskDetailsAreYouSureTitle => 'Task deletion';

  @override
  String get taskDetailsAreYouSureMsg => 'Are you sure to delete this task?';

  @override
  String get taskDetailsTaskNotStartedYet => 'Task not started yet';

  @override
  String get taskDetailsTimelineError => 'Error on fetching the timelines';

  @override
  String get taskDetailsStartTask => 'Start of task';

  @override
  String taskDetailsPauseDiff(String time) {
    return 'Pause ($time)';
  }

  @override
  String get taskDetailsCompletedExceededTime =>
      'Completed in more time than calculated';

  @override
  String get focusModeTitle => 'Focus mode';

  @override
  String get focusModeTaskFinished => 'Task finished!';

  @override
  String get focusModeExceededTime => 'Exceeded time';

  @override
  String get focusModeDndDeactivated => 'Do not disturb';

  @override
  String get focusModeDndActivated => 'Do not disturb activated';

  @override
  String get focusModeDndSilenceResources => 'Silence calls and notifications';

  @override
  String get focusModeTaskFinishSuccess => 'Task completed successfully!';

  @override
  String focusModeGoal(String mins) {
    return 'Goal · $mins';
  }

  @override
  String get focusModeExtraTime => 'Extra time';

  @override
  String get focusModeRemaining => 'Remaining';

  @override
  String get focusModeFinish => 'Finish';

  @override
  String get focusModeFinishDialogTitle => 'Task finished?';

  @override
  String get focusModeFinishDialogMsg =>
      'Have you finished the task ahead of schedule?';

  @override
  String get historicalTitle => 'Historical';

  @override
  String get historicalDateRangeSummary => 'Date range summary';

  @override
  String get historicalToday => 'Today';

  @override
  String get historicalThisWeek => 'This week';

  @override
  String get historicalThisMonth => 'This month';

  @override
  String get historicalRealTimeDevoted => 'Real time devoted';

  @override
  String get historicalPlannedTime => 'Planned time';

  @override
  String get historicalFocusRatio => 'Focus ratio';

  @override
  String get historicalMetricsError => 'Error on fetching metrics';

  @override
  String get historicalSummaryNoRecordsYet => 'There are no records yet';
}
