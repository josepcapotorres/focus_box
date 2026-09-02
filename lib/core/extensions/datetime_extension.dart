import 'package:flutter/material.dart' show BuildContext;
import 'package:intl/intl.dart';

import 'translations_extension.dart';

extension DateTimeExtension on DateTime {
  /// It converts a DateTime that might have time data
  /// and it ensures that we only manage Date, since we
  /// only need to manage the Date instead of the time
  DateTime get toDateOnly => DateTime(year, month, day);

  String formatDateWithSlashes(BuildContext context) {
    switch (context.l10n.localeName) {
      case "en":
        return DateFormat("yyyy/MM/dd", "en").format(this);
      case "es":
        return DateFormat("dd/MM/yyyy", "es").format(this);
      default:
        return "";
    }
  }

  DateTime getFirstDayOfCurrentWeek() {
    return subtract(Duration(days: weekday - DateTime.monday));
  }

  DateTime getLastDayOfCurrentWeek() {
    return add(Duration(days: DateTime.sunday - weekday));
  }

  DateTime getLastDayOfCurrentMonth() {
    return DateTime(year, month + 1, 0);
  }

  DateTime getFirstDayOfCurrentMonth() {
    return DateTime(year, month, 1);
  }
}
