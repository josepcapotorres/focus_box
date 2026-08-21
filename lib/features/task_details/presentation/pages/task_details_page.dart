import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_box/core/extensions/translations_extension.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/domain/entities/task.dart';
import '../../../../core/extensions/duration_formatting_extension.dart';
import '../../../../core/extensions/task_status_localization_extension.dart';
import '../../../../core/format/local_name_format.dart';
import '../../../../core/managers/crash_reporter.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/widgets/new_task_edit_bottom_sheet.dart';
import '../../../home/domain/repositories/home_repository.dart';
import '../../../home/presentation/providers/home_tasks_provider.dart';
import '../providers/task_details_history_provider.dart';
import '../widgets/task_details_metric_card.dart';
import '../widgets/tasks_details_time_line_steps.dart';

class TaskDetailsPage extends ConsumerWidget {
  static const routeName = "/task_details";

  final String taskId;

  const TaskDetailsPage(this.taskId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(currentTaskProvider(taskId));

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = ColorScheme.of(context);

    final timeTotal = (task?.timeTotal ?? Duration.zero);
    final strEstimatedTime = timeTotal.toDisplayHoursMinutes();

    final timeAlreadyDone = (task?.timeAlreadyDone ?? Duration.zero);
    final strRealTime = timeAlreadyDone.toDisplayHoursMinutes();
    final difference = timeAlreadyDone - timeTotal;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.taskDetailsTitle),
        actions: [
          IconButton(
            onPressed: () => _showNewTaskBottomSheet(context, task),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () => _showAreYouSureDialog(context, ref, taskId),
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: task == null
              ? Center(child: Text(context.l10n.taskDetailsTaskNotFound))
              : Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      spacing: 24,
                      children: [
                        Expanded(
                          child: Text(task.name, style: textTheme.titleLarge),
                        ),
                        Chip(
                          backgroundColor: task.status.backgroundColor,
                          label: Text(
                            task.status.label(context.l10n),
                            style: textTheme.labelMedium?.copyWith(
                              color: task.status.foregroundColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: AppColors.borderLight),
                    Padding(
                      padding: const EdgeInsets.only(top: 18, bottom: 32),
                      child: Row(
                        mainAxisAlignment: .spaceBetween,
                        spacing: 24,
                        children: [
                          Text(showFormattedDateWithDayName(context, task.day)),
                          const Text("09:00 - 11:35"),
                        ],
                      ),
                    ),
                    Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: TaskDetailsMetricCard(
                            label: context.l10n.taskDetailsEstimatedTime,
                            metricValue: "${strEstimatedTime}h",
                            backgroundColor: colorScheme.surface,
                            labelColor: colorScheme.onSurface,
                            metricColor: colorScheme.onSurface,
                          ),
                        ),
                        Expanded(
                          child: TaskDetailsMetricCard(
                            label: context.l10n.taskDetailsRealTime,
                            metricValue: "${strRealTime}h",
                            backgroundColor: colorScheme.surface,
                            labelColor: colorScheme.onSurface,
                            metricColor: colorScheme.onSurface,
                          ),
                        ),
                        Expanded(
                          child: TaskDetailsMetricCard(
                            label: context.l10n.taskDetailsDifference,
                            metricValue:
                                "${difference.isNegative ? "" : "+"} ${difference.inMinutes} min",
                            backgroundColor: colorScheme.surface,
                            labelColor: colorScheme.onSurface,
                            metricColor:
                                difference.inMinutes >= 10 &&
                                    difference.inMinutes <= 10
                                ? colorScheme.onSurface
                                : AppColors.warning,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(
                      context.l10n.taskDetailsTimeline,
                      style: textTheme.headlineSmall,
                    ),
                    TasksDetailsTimeLineSteps(taskId),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _showNewTaskBottomSheet(BuildContext context, Task? task) async {
    if (task == null) return;

    await showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => NewTaskEditBottomSheet(task: task),
    );
  }

  void _showAreYouSureDialog(
    BuildContext context,
    WidgetRef ref,
    String taskId,
  ) {
    showAdaptiveDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(context.l10n.taskDetailsAreYouSureTitle),
        content: Text(context.l10n.taskDetailsAreYouSureMsg),
        actions: [
          TextButton(
            onPressed: context.pop,
            child: Text(context.l10n.commonNo),
          ),
          TextButton(
            onPressed: () async {
              context.pop();

              final homeRepository = await ref.read(
                homeRepositoryProvider.future,
              );

              try {
                homeRepository.deleteTask(taskId);
                ref
                    .read(taskDetailsHistoryProvider.notifier)
                    .deleteTaskEntries(taskId);
              } catch (e, s) {
                ref.read(crashReporterProvider).recordError(e, s);
              }

              if (!context.mounted) return;
              context.pop();
            },
            child: Text(context.l10n.commonYes),
          ),
        ],
      ),
    );
  }
}
