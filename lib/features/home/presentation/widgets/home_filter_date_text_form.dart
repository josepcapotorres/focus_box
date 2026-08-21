import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/datetime_extension.dart';
import '../providers/home_selected_date_filter.dart';

class HomeFilterDateTextForm extends ConsumerWidget {
  const HomeFilterDateTextForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ColorScheme.of(context);

    final selectedDateFilter = ref.watch(homeSelectedDateFilterProvider);
    final formattedDateFilter = selectedDateFilter.formatDateWithSlashes(
      context,
    );

    return TextFormField(
      controller: TextEditingController(text: formattedDateFilter),
      readOnly: true,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.event),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: const .all(.circular(12)),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const .all(.circular(12)),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.0),
        ),
      ),
      onTap: () => _showDatePicker(context, ref, selectedDateFilter),
    );
  }

  void _showDatePicker(
    BuildContext context,
    WidgetRef ref,
    DateTime selectedDateFilter,
  ) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateFilter,
      firstDate: selectedDateFilter.getFirstDayOfCurrentMonth(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );

    if (selectedDate == null) return;

    ref.read(homeSelectedDateFilterProvider.notifier).setDate(selectedDate);
  }
}
