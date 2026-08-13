import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_box/features/history/presentation/providers/history_date_ranges_filter_provider.dart';
import 'package:intl/intl.dart';

class HistorySelectedFilterDates extends ConsumerWidget {
  const HistorySelectedFilterDates({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (firstDay, today) = ref.watch(historyRateRangesFilterProvider);

    final titleSmall = Theme.of(context).textTheme.titleSmall;

    final fullDateFormat = DateFormat("d 'de' MMMM");
    final formattedFirstDay = fullDateFormat.format(firstDay);
    final formattedToday = fullDateFormat.format(today);
    String textToShow = formattedFirstDay;

    if (formattedToday.isNotEmpty) textToShow += " - $formattedToday";

    return Text(textToShow, style: titleSmall);
  }
}
