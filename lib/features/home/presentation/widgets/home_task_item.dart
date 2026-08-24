import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/domain/entities/task.dart';
import '../../../../core/domain/enums/task_status.dart';
import '../../../../core/extensions/duration_formatting_extension.dart';
import '../../../../core/extensions/task_status_localization_extension.dart';
import '../../../../core/extensions/translations_extension.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/widgets/horizontal_bar_chart.dart';
import '../../../focus_mode/presentation/pages/focus_mode_page.dart';
import '../../../focus_mode/presentation/providers/focus_session_provider.dart';
import '../../../history/presentation/providers/history_current_filter_provider.dart';
import '../providers/home_tasks_provider.dart';

class HomeTaskItem extends ConsumerWidget {
  final String taskId;
  final VoidCallback? onTap;

  const HomeTaskItem({super.key, required this.taskId, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ColorScheme.of(context);
    final currentTask = ref.watch(currentTaskProvider(taskId));

    if (currentTask == null) return const SizedBox.shrink();

    final showActionButton = _showActionButton(ref, currentTask);
    final foregroundColor = _computeForegroundColor(currentTask);
    final inProgress = <TaskStatus>[
      .inProgress,
      .exceededInProgress,
    ].contains(currentTask.status);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const .all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      spacing: 16,
                      children: [
                        _Header(currentTask),
                        HorizontalBarChart(
                          taskId: taskId,
                          totalValue: 100,
                          foregroundColor: foregroundColor,
                          backgroundColor: colorScheme.primaryContainer,
                        ),
                      ],
                    ),
                  ),
                  if (inProgress) ...[
                    const SizedBox(width: 16),
                    _FocusModeButton(currentTask.id),
                  ],
                  const SizedBox(width: 16),
                  if (showActionButton) _ActionButton(currentTask),
                ],
              ),
              const SizedBox(height: 8),
              _FooterTexts(taskId),
            ],
          ),
        ),
      ),
    );
  }

  bool _showActionButton(WidgetRef ref, Task currentTask) {
    final selectedFilter = ref.watch(historyCurrentFilterProvider);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final currentTaskDay = DateTime(
      currentTask.day.year,
      currentTask.day.month,
      currentTask.day.day,
    );

    return today.difference(currentTaskDay) == .zero &&
        selectedFilter == .today;
  }

  Color _computeForegroundColor(Task currentTask) {
    return currentTask.isExceeded
        ? AppColors.warning
        : currentTask.status.foregroundColor;
  }
}

class _Header extends StatelessWidget {
  final Task task;

  const _Header(this.task);

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    final statusColor = task.status == .exceeded ? AppColors.warning : null;

    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Text(
            task.name,
            style: textTheme.titleMedium?.copyWith(color: statusColor),
          ),
        ),
        _Chip(task.status),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final TaskStatus status;

  const _Chip(this.status);

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: status.backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: SizedBox(
        height: 28,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: Text(
            status.label(context.l10n),
            style: textTheme.labelMedium?.copyWith(
              color: status.foregroundColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _FocusModeButton extends StatelessWidget {
  final String taskId;

  const _FocusModeButton(this.taskId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(FocusModePage.routeName, extra: taskId),
      child: const CircleAvatar(
        backgroundColor: AppColors.primary,
        child: Icon(Icons.timer_outlined, color: AppColors.surfaceLight),
      ),
    );
  }
}

class _ActionButton extends ConsumerWidget {
  final Task task;

  const _ActionButton(this.task);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (task.status) {
      TaskStatus.inProgress => _PauseButton(task.id),
      TaskStatus.completed => _CheckButton(exceeded: task.isExceeded),
      TaskStatus.paused => _PlayButton(task),
      TaskStatus.exceeded => const _WarningButton(),
      /*_PlayButton(
        task,
        backgroundColor: AppColors.warning,
      ),*/
      TaskStatus.pending => _PlayButton(task),
      TaskStatus.exceededInProgress => _PauseButton(task.id),
    };
  }
}

class _PauseButton extends ConsumerWidget {
  final String taskId;

  const _PauseButton(this.taskId);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(focusSessionProvider.notifier).pause();
      },
      child: const CircleAvatar(
        backgroundColor: AppColors.primary,
        child: Icon(Icons.pause, color: AppColors.surfaceLight),
      ),
    );
  }
}

class _PlayButton extends ConsumerWidget {
  final Task task;
  final Color? backgroundColor;

  const _PlayButton(this.task, {this.backgroundColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(focusSessionProvider.notifier).startTask(task);
        context.push(FocusModePage.routeName, extra: task.id);
      },
      child: CircleAvatar(
        backgroundColor: backgroundColor ?? AppColors.paused,
        child: const Icon(Icons.play_arrow, color: AppColors.surfaceLight),
      ),
    );
  }
}

class _CheckButton extends StatelessWidget {
  final bool exceeded;

  const _CheckButton({required this.exceeded});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return GestureDetector(
      onTap: () {},
      child: CircleAvatar(
        backgroundColor: exceeded ? AppColors.warning : colorScheme.secondary,
        child: const Icon(Icons.check, color: AppColors.surfaceLight),
      ),
    );
  }
}

class _WarningButton extends StatelessWidget {
  const _WarningButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: const Icon(
        Icons.warning_rounded,
        color: AppColors.warning,
        size: 42,
      ),
    );
  }
}

class _FooterTexts extends ConsumerWidget {
  final String taskId;

  const _FooterTexts(this.taskId);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = TextTheme.of(context);
    final colorScheme = ColorScheme.of(context);

    final task = ref.watch(currentTaskProvider(taskId));
    final currentTaskId = ref.watch(
      focusSessionProvider.select((s) => s?.taskId),
    );
    final currentStatus = ref.watch(
      focusSessionProvider.select((s) => s?.status),
    );

    final isCurrentTask = currentTaskId == task?.id;

    final timeAlreadyDone = task?.timeAlreadyDone ?? Duration.zero;
    final timeTotal = task?.timeTotal ?? Duration.zero;

    final workedShownMinutes = timeAlreadyDone.inMinutes;
    final totalShownMinutes = timeTotal.inMinutes;
    final remainingMinutes = max(0, timeTotal.inMinutes - workedShownMinutes);

    final exceededShownMinutes = (workedShownMinutes - totalShownMinutes).clamp(
      0,
      999,
    );

    final status = isCurrentTask && currentStatus != null
        ? currentStatus
        : task?.status;

    return Row(
      children: [
        if (status != .pending) ...[
          if (status != .completed && status != .exceeded)
            Text(
              context.l10n.homeMinsLeft(remainingMinutes.toString()),
              style: textTheme.bodySmall,
            )
          else if (status == .exceeded && exceededShownMinutes != 0)
            Text(
              context.l10n.homeMinsExceeded(exceededShownMinutes.toString()),
              style: textTheme.bodySmall,
            ),
          Expanded(
            child: Text(
              "${timeAlreadyDone.toDisplayHoursMinutes()} / ${timeTotal.toDisplayHoursMinutes()}",
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: .right,
            ),
          ),
        ],
      ],
    );
  }
}
