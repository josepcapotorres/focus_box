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
  String get homeToday => 'Hoy';

  @override
  String get homeTomorrow => 'Mañana';

  @override
  String homeTodayLabel(String date) {
    return 'Hoy, $date';
  }

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
    return ' · +$mins min excedida';
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
}
