import 'package:flutter/material.dart' show BuildContext;
import 'package:intl/intl.dart' show DateFormat;

import '../extensions/translations_extension.dart';

const _englishDateFormatWithDayName = "MMMM d";
const _spanishDateFormatWithName = "d 'de' MMMM";

String showFormattedDateWithoutDayName(BuildContext context, DateTime date) {
  String label;

  switch (context.l10n.localeName) {
    case "en":
      final fullDateFormat = DateFormat(_englishDateFormatWithDayName, "en");
      label = fullDateFormat.format(date);
      break;
    case "es":
      final fullDateFormat = DateFormat(_spanishDateFormatWithName, "es");
      label = fullDateFormat.format(date);
      break;
    default:
      label = "";
  }

  return label;
}

String showFormattedDayName(BuildContext context, DateTime date) {
  String label;

  switch (context.l10n.localeName) {
    case "en":
      final fullDateFormat = DateFormat("EEEE", "en");
      label = fullDateFormat.format(date);
      break;
    case "es":
      final fullDateFormat = DateFormat("EEEE", "es");
      label = fullDateFormat.format(date);
      break;
    default:
      label = "";
  }

  return label;
}
