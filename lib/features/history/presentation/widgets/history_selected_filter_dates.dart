import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_box/features/history/presentation/providers/history_date_ranges_filter_provider.dart';

import '../../../../core/format/local_name_format.dart';

class HistorySelectedFilterDates extends ConsumerWidget {
  const HistorySelectedFilterDates({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (firstDay, today) = ref.watch(historyRateRangesFilterProvider);

    final titleSmall = Theme.of(context).textTheme.titleSmall;

    final formattedFirstDay = showFormattedDateWithoutDayName(
      context,
      firstDay,
    );
    final formattedToday = showFormattedDateWithoutDayName(context, today);
    String textToShow = formattedFirstDay;

    if (formattedToday.isNotEmpty) textToShow += " - $formattedToday";

    return Text(textToShow, style: titleSmall);
  }
}
