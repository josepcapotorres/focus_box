// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get commonNoResults => 'No hay resultados';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonTaskInProgress => 'En progreso';

  @override
  String get commonTaskCompleted => 'Completada';

  @override
  String get commonTaskPaused => 'Pausada';

  @override
  String get commonTaskExceeded => 'Excedida';

  @override
  String get commonTaskPending => 'Pendiente';

  @override
  String get commonNo => 'No';

  @override
  String get commonYes => 'Sí';

  @override
  String get homeTitle => 'FocusBox';

  @override
  String get homeViewSelectedDateTask =>
      'Ver las tareas de la fecha seleccionada';

  @override
  String get homeToday => 'Hoy';

  @override
  String get homeListError => 'Error al obtener las tareas para hoy';

  @override
  String get homeHistorical => 'Historial';

  @override
  String homeMinsLeft(String mins) {
    return 'Quedan $mins min';
  }

  @override
  String homeMinsExceeded(String mins) {
    return '+$mins min excedida';
  }

  @override
  String get saveEditTaskNewTaskTitle => 'Nueva tarea';

  @override
  String get saveEditTaskEditTaskTitle => 'Editar tarea';

  @override
  String get saveEditTaskTaskName => 'Nombre de la tarea';

  @override
  String get saveEditTaskTimeEstimated => 'Estimación de tiempo';

  @override
  String get saveEditTaskAssignDay => 'Asignación de día';

  @override
  String get taskDetailsTitle => 'Detalles de la tarea';

  @override
  String get taskDetailsTaskNotFound => 'No se ha encontrado la tarea';

  @override
  String get taskDetailsEstimatedTime => 'Tiempo estimado';

  @override
  String get taskDetailsRealTime => 'Tiempo real';

  @override
  String get taskDetailsDifference => 'Diferencia';

  @override
  String get taskDetailsTimeline => 'Línea de tiempo';

  @override
  String get taskDetailsAreYouSureTitle => 'Eliminación de tarea';

  @override
  String get taskDetailsAreYouSureMsg =>
      '¿Estás seguro de querer eliminar esta tarea?';

  @override
  String get taskDetailsTaskNotStartedYet => 'Aún no se ha iniciado la tarea';

  @override
  String get taskDetailsTimelineError =>
      'Error al obtener las líneas de tiempo';

  @override
  String get taskDetailsStartTask => 'Inicio de la tarea';

  @override
  String taskDetailsPauseDiff(String time) {
    return 'Pausa ($time)';
  }

  @override
  String get taskDetailsCompletedExceededTime =>
      'Completada con más tiempo del calculado';

  @override
  String get taskDetailsExceededInProgress =>
      'Tarea excedida y aún en progreso';

  @override
  String get focusModeTitle => 'Modo enfoque';

  @override
  String get focusModeTaskFinished => '¡Tarea finalizada!';

  @override
  String get focusModeExceededTime => 'Tiempo excedido';

  @override
  String get focusModeDndDeactivated => 'No molestar';

  @override
  String get focusModeDndActivated => 'No molestar activado';

  @override
  String get focusModeDndSilenceResources =>
      'Silencia llamadas y notificaciones';

  @override
  String get focusModeTaskFinishSuccess => '¡Tarea completada con éxito! 🎉';

  @override
  String focusModeGoal(String mins) {
    return 'Objetivo · $mins';
  }

  @override
  String get focusModeExtraTime => 'Tiempo extra';

  @override
  String get focusModeRemaining => 'Restante';

  @override
  String get focusModeFinish => 'Finalizar';

  @override
  String get focusModeFinishDialogTitle => 'Tarea finalizada?';

  @override
  String get focusModeFinishDialogMsg =>
      '¿Has acabado la tarea antes de tiempo?';

  @override
  String get historicalTitle => 'Historial';

  @override
  String get historicalDateRangeSummary => 'Resumen del rango de fechas';

  @override
  String get historicalToday => 'Hoy';

  @override
  String get historicalThisWeek => 'Esta semana';

  @override
  String get historicalThisMonth => 'Este mes';

  @override
  String get historicalRealTimeDevoted => 'Tiempo real dedicado';

  @override
  String get historicalPlannedTime => 'Tiempo planificado';

  @override
  String get historicalFocusRatio => 'Ratio de enfoque';

  @override
  String get historicalMetricsError => 'Error al obtener las métricas';

  @override
  String get historicalSummaryNoRecordsYet => 'Aún no hay registros';
}
