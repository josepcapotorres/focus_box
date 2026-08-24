import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @commonNoResults.
  ///
  /// In es, this message translates to:
  /// **'No hay resultados'**
  String get commonNoResults;

  /// No description provided for @commonCancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get commonSave;

  /// No description provided for @commonTaskInProgress.
  ///
  /// In es, this message translates to:
  /// **'En progreso'**
  String get commonTaskInProgress;

  /// No description provided for @commonTaskCompleted.
  ///
  /// In es, this message translates to:
  /// **'Completada'**
  String get commonTaskCompleted;

  /// No description provided for @commonTaskPaused.
  ///
  /// In es, this message translates to:
  /// **'Pausada'**
  String get commonTaskPaused;

  /// No description provided for @commonTaskExceeded.
  ///
  /// In es, this message translates to:
  /// **'Excedida'**
  String get commonTaskExceeded;

  /// No description provided for @commonTaskPending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get commonTaskPending;

  /// No description provided for @commonNo.
  ///
  /// In es, this message translates to:
  /// **'No'**
  String get commonNo;

  /// No description provided for @commonYes.
  ///
  /// In es, this message translates to:
  /// **'Sí'**
  String get commonYes;

  /// No description provided for @homeTitle.
  ///
  /// In es, this message translates to:
  /// **'FocusBox'**
  String get homeTitle;

  /// No description provided for @homeViewSelectedDateTask.
  ///
  /// In es, this message translates to:
  /// **'Ver las tareas de la fecha seleccionada'**
  String get homeViewSelectedDateTask;

  /// No description provided for @homeToday.
  ///
  /// In es, this message translates to:
  /// **'Hoy'**
  String get homeToday;

  /// No description provided for @homeListError.
  ///
  /// In es, this message translates to:
  /// **'Error al obtener las tareas para hoy'**
  String get homeListError;

  /// No description provided for @homeHistorical.
  ///
  /// In es, this message translates to:
  /// **'Historial'**
  String get homeHistorical;

  /// No description provided for @homeMinsLeft.
  ///
  /// In es, this message translates to:
  /// **'Quedan {mins} min'**
  String homeMinsLeft(String mins);

  /// No description provided for @homeMinsExceeded.
  ///
  /// In es, this message translates to:
  /// **'+{mins} min excedida'**
  String homeMinsExceeded(String mins);

  /// No description provided for @saveEditTaskNewTaskTitle.
  ///
  /// In es, this message translates to:
  /// **'Nueva tarea'**
  String get saveEditTaskNewTaskTitle;

  /// No description provided for @saveEditTaskEditTaskTitle.
  ///
  /// In es, this message translates to:
  /// **'Editar tarea'**
  String get saveEditTaskEditTaskTitle;

  /// No description provided for @saveEditTaskTaskName.
  ///
  /// In es, this message translates to:
  /// **'Nombre de la tarea'**
  String get saveEditTaskTaskName;

  /// No description provided for @saveEditTaskTimeEstimated.
  ///
  /// In es, this message translates to:
  /// **'Estimación de tiempo'**
  String get saveEditTaskTimeEstimated;

  /// No description provided for @saveEditTaskAssignDay.
  ///
  /// In es, this message translates to:
  /// **'Asignación de día'**
  String get saveEditTaskAssignDay;

  /// No description provided for @taskDetailsTitle.
  ///
  /// In es, this message translates to:
  /// **'Detalles de la tarea'**
  String get taskDetailsTitle;

  /// No description provided for @taskDetailsTaskNotFound.
  ///
  /// In es, this message translates to:
  /// **'No se ha encontrado la tarea'**
  String get taskDetailsTaskNotFound;

  /// No description provided for @taskDetailsEstimatedTime.
  ///
  /// In es, this message translates to:
  /// **'Tiempo estimado'**
  String get taskDetailsEstimatedTime;

  /// No description provided for @taskDetailsRealTime.
  ///
  /// In es, this message translates to:
  /// **'Tiempo real'**
  String get taskDetailsRealTime;

  /// No description provided for @taskDetailsDifference.
  ///
  /// In es, this message translates to:
  /// **'Diferencia'**
  String get taskDetailsDifference;

  /// No description provided for @taskDetailsTimeline.
  ///
  /// In es, this message translates to:
  /// **'Línea de tiempo'**
  String get taskDetailsTimeline;

  /// No description provided for @taskDetailsAreYouSureTitle.
  ///
  /// In es, this message translates to:
  /// **'Eliminación de tarea'**
  String get taskDetailsAreYouSureTitle;

  /// No description provided for @taskDetailsAreYouSureMsg.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de querer eliminar esta tarea?'**
  String get taskDetailsAreYouSureMsg;

  /// No description provided for @taskDetailsTaskNotStartedYet.
  ///
  /// In es, this message translates to:
  /// **'Aún no se ha iniciado la tarea'**
  String get taskDetailsTaskNotStartedYet;

  /// No description provided for @taskDetailsTimelineError.
  ///
  /// In es, this message translates to:
  /// **'Error al obtener las líneas de tiempo'**
  String get taskDetailsTimelineError;

  /// No description provided for @taskDetailsStartTask.
  ///
  /// In es, this message translates to:
  /// **'Inicio de la tarea'**
  String get taskDetailsStartTask;

  /// No description provided for @taskDetailsPauseDiff.
  ///
  /// In es, this message translates to:
  /// **'Pausa ({time})'**
  String taskDetailsPauseDiff(String time);

  /// No description provided for @taskDetailsCompletedExceededTime.
  ///
  /// In es, this message translates to:
  /// **'Completada con más tiempo del calculado'**
  String get taskDetailsCompletedExceededTime;

  /// No description provided for @taskDetailsExceededInProgress.
  ///
  /// In es, this message translates to:
  /// **'Tarea excedida y aún en progreso'**
  String get taskDetailsExceededInProgress;

  /// No description provided for @focusModeTitle.
  ///
  /// In es, this message translates to:
  /// **'Modo enfoque'**
  String get focusModeTitle;

  /// No description provided for @focusModeTaskFinished.
  ///
  /// In es, this message translates to:
  /// **'¡Tarea finalizada!'**
  String get focusModeTaskFinished;

  /// No description provided for @focusModeExceededTime.
  ///
  /// In es, this message translates to:
  /// **'Tiempo excedido'**
  String get focusModeExceededTime;

  /// No description provided for @focusModeDndDeactivated.
  ///
  /// In es, this message translates to:
  /// **'No molestar'**
  String get focusModeDndDeactivated;

  /// No description provided for @focusModeDndActivated.
  ///
  /// In es, this message translates to:
  /// **'No molestar activado'**
  String get focusModeDndActivated;

  /// No description provided for @focusModeDndSilenceResources.
  ///
  /// In es, this message translates to:
  /// **'Silencia llamadas y notificaciones'**
  String get focusModeDndSilenceResources;

  /// No description provided for @focusModeTaskFinishSuccess.
  ///
  /// In es, this message translates to:
  /// **'¡Tarea completada con éxito! 🎉'**
  String get focusModeTaskFinishSuccess;

  /// No description provided for @focusModeGoal.
  ///
  /// In es, this message translates to:
  /// **'Objetivo · {mins}'**
  String focusModeGoal(String mins);

  /// No description provided for @focusModeExtraTime.
  ///
  /// In es, this message translates to:
  /// **'Tiempo extra'**
  String get focusModeExtraTime;

  /// No description provided for @focusModeRemaining.
  ///
  /// In es, this message translates to:
  /// **'Restante'**
  String get focusModeRemaining;

  /// No description provided for @focusModeFinish.
  ///
  /// In es, this message translates to:
  /// **'Finalizar'**
  String get focusModeFinish;

  /// No description provided for @focusModeFinishDialogTitle.
  ///
  /// In es, this message translates to:
  /// **'Tarea finalizada?'**
  String get focusModeFinishDialogTitle;

  /// No description provided for @focusModeFinishDialogMsg.
  ///
  /// In es, this message translates to:
  /// **'¿Has acabado la tarea antes de tiempo?'**
  String get focusModeFinishDialogMsg;

  /// No description provided for @historicalTitle.
  ///
  /// In es, this message translates to:
  /// **'Historial'**
  String get historicalTitle;

  /// No description provided for @historicalDateRangeSummary.
  ///
  /// In es, this message translates to:
  /// **'Resumen del rango de fechas'**
  String get historicalDateRangeSummary;

  /// No description provided for @historicalToday.
  ///
  /// In es, this message translates to:
  /// **'Hoy'**
  String get historicalToday;

  /// No description provided for @historicalThisWeek.
  ///
  /// In es, this message translates to:
  /// **'Esta semana'**
  String get historicalThisWeek;

  /// No description provided for @historicalThisMonth.
  ///
  /// In es, this message translates to:
  /// **'Este mes'**
  String get historicalThisMonth;

  /// No description provided for @historicalRealTimeDevoted.
  ///
  /// In es, this message translates to:
  /// **'Tiempo real dedicado'**
  String get historicalRealTimeDevoted;

  /// No description provided for @historicalPlannedTime.
  ///
  /// In es, this message translates to:
  /// **'Tiempo planificado'**
  String get historicalPlannedTime;

  /// No description provided for @historicalFocusRatio.
  ///
  /// In es, this message translates to:
  /// **'Ratio de enfoque'**
  String get historicalFocusRatio;

  /// No description provided for @historicalMetricsError.
  ///
  /// In es, this message translates to:
  /// **'Error al obtener las métricas'**
  String get historicalMetricsError;

  /// No description provided for @historicalSummaryNoRecordsYet.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay registros'**
  String get historicalSummaryNoRecordsYet;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
