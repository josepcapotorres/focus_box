import 'package:flutter/material.dart';

import '../domain/enums/task_status.dart';
import '../extensions/translations_extension.dart';

class TaskStatusChip extends StatelessWidget {
  final TaskStatus status;

  const TaskStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final style = _style(context, colorScheme);

    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        style.label,
        style: textTheme.labelMedium?.copyWith(color: style.foregroundColor),
      ),
    );
  }

  _TaskStatusStyle _style(BuildContext context, ColorScheme colorScheme) {
    switch (status) {
      case TaskStatus.pending:
        return _TaskStatusStyle(
          label: context.l10n.commonTaskPending,
          foregroundColor: colorScheme.onSurfaceVariant,
          backgroundColor: colorScheme.surfaceContainerHighest,
        );

      case TaskStatus.inProgress:
        return _TaskStatusStyle(
          label: context.l10n.commonTaskInProgress,
          foregroundColor: colorScheme.primary,
          backgroundColor: colorScheme.primaryContainer,
        );

      case TaskStatus.completed:
        return _TaskStatusStyle(
          label: context.l10n.commonTaskCompleted,
          foregroundColor: colorScheme.onSecondaryContainer,
          backgroundColor: colorScheme.secondaryContainer,
        );

      case TaskStatus.paused:
        return _TaskStatusStyle(
          label: context.l10n.commonTaskPaused,
          foregroundColor: colorScheme.onSurfaceVariant,
          backgroundColor: colorScheme.surfaceContainerHighest,
        );

      case TaskStatus.exceeded:
        return _TaskStatusStyle(
          label: context.l10n.focusModeExceededTime,
          foregroundColor: colorScheme.onErrorContainer,
          backgroundColor: colorScheme.errorContainer,
        );
    }
  }
}

class _TaskStatusStyle {
  final String label;
  final Color foregroundColor;
  final Color backgroundColor;

  const _TaskStatusStyle({
    required this.label,
    required this.foregroundColor,
    required this.backgroundColor,
  });
}
