import 'package:flutter/material.dart' show BuildContext;
import 'package:intl/intl.dart' show DateFormat;

import '../extensions/translations_extension.dart';

const _englishDateFormatWithDayName = "MMMM d";
const _spanishDateFormatWithName = "d 'de' MMMM";

String showFormattedDateWithDayName(BuildContext context, DateTime today) {
  String label;

  switch (context.l10n.localeName) {
    case "en":
      final fullDateFormat = DateFormat(_englishDateFormatWithDayName, "en");
      label = context.l10n.homeTodayLabel(fullDateFormat.format(today));
      break;
    case "es":
      final fullDateFormat = DateFormat(_spanishDateFormatWithName, "es");
      label = context.l10n.homeTodayLabel(fullDateFormat.format(today));
      break;
    default:
      label = "";
  }

  return label;
}

String showFormattedDateWithoutDayName(BuildContext context, DateTime today) {
  String label;

  switch (context.l10n.localeName) {
    case "en":
      final fullDateFormat = DateFormat(_englishDateFormatWithDayName, "en");
      label = fullDateFormat.format(today);
      break;
    case "es":
      final fullDateFormat = DateFormat(_spanishDateFormatWithName, "es");
      label = fullDateFormat.format(today);
      break;
    default:
      label = "";
  }

  return label;
}
