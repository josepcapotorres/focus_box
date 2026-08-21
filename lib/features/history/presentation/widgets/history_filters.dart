import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/translations_extension.dart';
import '../../domain/enums/history_range_enum.dart';
import '../providers/history_current_filter_provider.dart';

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
            labelPadding: const .symmetric(vertical: 2, horizontal: 8),
            label: Text(
              context.l10n.historicalToday,
              style: textTheme.labelLarge?.copyWith(
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
            labelPadding: const .symmetric(vertical: 2, horizontal: 8),
            label: Text(
              context.l10n.historicalThisWeek,
              style: textTheme.labelLarge?.copyWith(
                color: selectedFilter == HistoryRange.currentWeek
                    ? Colors.white
                    : null,
              ),
              textAlign: .center,
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
            labelPadding: const .symmetric(vertical: 2, horizontal: 8),
            label: Text(
              context.l10n.historicalThisMonth,
              style: textTheme.labelLarge?.copyWith(
                color: selectedFilter == HistoryRange.currentMonth
                    ? Colors.white
                    : null,
              ),
              textAlign: .center,
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
