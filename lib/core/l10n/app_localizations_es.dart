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
  String get saveEditTaskNewTaskTitle => 'Nueva tarea';

  @override
  String get saveEditTaskEditTaskTitle => 'Editar tarea';

  @override
  String get saveEditTaskTaskName => 'Nombre de la tarea';

  @override
  String get saveEditTaskTimeEstimated => 'Estimación de tiempo';

  @override
  String get saveEditTaskAssignDay => 'Asignación de día';
}
