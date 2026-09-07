import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/themes/app_colors.dart';
import '../providers/home_selected_date_filter.dart';
import 'home_filter_date_text_form.dart';

class HomeFilterDate extends ConsumerWidget {
  const HomeFilterDate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ColorScheme.of(context);

    ref.watch(homeSelectedDateFilterProvider);
    final notifier = ref.read(homeSelectedDateFilterProvider.notifier);

    final prevButtonColor = notifier.prevButtonEnabled
        ? colorScheme.primary
        : AppColors.textSecondaryDark;

    final nextButtonColor = notifier.nextButtonEnabled
        ? colorScheme.primary
        : AppColors.textSecondaryDark;

    return Row(
      spacing: 8,
      children: [
        _RoundedDecoratedWidget(
          enabled: notifier.prevButtonEnabled,
          child: IconButton(
            onPressed: notifier.prevButtonEnabled
                ? notifier.setPreviousDay
                : null,
            icon: Icon(Icons.chevron_left, color: prevButtonColor),
          ),
        ),
        const Expanded(child: HomeFilterDateTextForm()),
        _RoundedDecoratedWidget(
          enabled: notifier.nextButtonEnabled,
          child: IconButton(
            onPressed: notifier.nextButtonEnabled ? notifier.setNextDay : null,
            icon: Icon(Icons.chevron_right, color: nextButtonColor),
          ),
        ),
      ],
    );
  }
}

class _RoundedDecoratedWidget extends StatelessWidget {
  final bool enabled;
  final Widget child;

  const _RoundedDecoratedWidget({required this.child, required this.enabled});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: BoxBorder.all(
          color: enabled ? colorScheme.primary : AppColors.textSecondaryDark,
        ),
        borderRadius: const .all(.circular(12)),
      ),
      child: child,
    );
  }
}
