import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_box/features/history/presentation/providers/history_current_filter_provider.dart';

import '../../domain/enums/history_range_enum.dart';

class HistoryFilters extends ConsumerWidget {
  const HistoryFilters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final selectedFilter = ref.watch(historyCurrentFilterProvider);

    return Row(
      spacing: 8,
      mainAxisAlignment: .center,
      children: [
        GestureDetector(
          onTap: () => ref
              .read(historyCurrentFilterProvider.notifier)
              .setCurrentFilter(HistoryRange.today),
          child: Chip(
            label: Text(
              "Hoy",
              style: textTheme.titleMedium?.copyWith(
                color: selectedFilter == HistoryRange.today
                    ? Colors.white
                    : null,
              ),
            ),
            backgroundColor: selectedFilter == HistoryRange.today
                ? colorScheme.primary
                : null,
          ),
        ),
        GestureDetector(
          onTap: () => ref
              .read(historyCurrentFilterProvider.notifier)
              .setCurrentFilter(HistoryRange.currentWeek),
          child: Chip(
            label: Text(
              "Esta semana",
              style: textTheme.titleMedium?.copyWith(
                color: selectedFilter == HistoryRange.currentWeek
                    ? Colors.white
                    : null,
              ),
            ),
            backgroundColor: selectedFilter == HistoryRange.currentWeek
                ? colorScheme.primary
                : null,
          ),
        ),
        GestureDetector(
          onTap: () => ref
              .read(historyCurrentFilterProvider.notifier)
              .setCurrentFilter(HistoryRange.currentMonth),
          child: Chip(
            label: Text(
              "Este mes",
              style: textTheme.titleMedium?.copyWith(
                color: selectedFilter == HistoryRange.currentMonth
                    ? Colors.white
                    : null,
              ),
            ),
            backgroundColor: selectedFilter == HistoryRange.currentMonth
                ? colorScheme.primary
                : null,
          ),
        ),
      ],
    );
  }
}
