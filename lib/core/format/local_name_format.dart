import 'package:flutter/material.dart' show BuildContext;
import 'package:intl/intl.dart' show DateFormat;

import '../extensions/translations_extension.dart';

String showFormattedDateLabel(BuildContext context, DateTime today) {
  String label;

  switch (context.l10n.localeName) {
    case "en":
      final fullDateFormat = DateFormat("MMMM d", "en");
      label = context.l10n.homeTodayLabel(fullDateFormat.format(today));
      break;
    case "es":
      final fullDateFormat = DateFormat("d 'de' MMMM", "es");
      label = context.l10n.homeTodayLabel(fullDateFormat.format(today));
      break;
    default:
      label = "";
  }

  return label;
}
