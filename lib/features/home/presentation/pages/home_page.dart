import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/translations_extension.dart';
import '../../../../core/format/local_name_format.dart';
import '../../../../core/managers/crash_reporter.dart';
import '../../../../core/widgets/new_task_edit_bottom_sheet.dart';
import '../../../task_details/presentation/pages/task_details_page.dart';
import '../../domain/enums/task_filter_enum.dart';
import '../providers/home_tasks_provider.dart';
import '../providers/task_details_current_filter_provider.dart';
import '../widgets/home_task_item.dart';

class HomePage extends ConsumerWidget {
  static const routeName = "/home";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = ColorScheme.of(context);

    final today = DateTime.now();

    final homeTasksAsync = ref.watch(homeFilteredTasksProvider);
    final currentFilter = ref.watch(taskDetailsCurrentFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.homeTitle,
          style: textTheme.titleLarge?.copyWith(color: colorScheme.primary),
        ),
        actions: [
          if (Platform.isIOS)
            IconButton(
              onPressed: () => _showNewTaskBottomSheet(context),
              icon: const Icon(Icons.add),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Align(
              alignment: .center,
              child: SizedBox(
                width: 250,
                child: SegmentedButton(
                  segments: [
                    ButtonSegment<TaskFilterEnum>(
                      value: .today,
                      label: Text(context.l10n.homeToday),
                    ),
                    ButtonSegment<TaskFilterEnum>(
                      value: .nextDay,
                      label: Text(context.l10n.homeTomorrow),
                    ),
                  ],
                  selected: {currentFilter},
                  onSelectionChanged: (newFilter) => ref
                      .read(taskDetailsCurrentFilterProvider.notifier)
                      .setFilter(newFilter.first),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              showFormattedDateWithDayName(context, today),
              style: textTheme.displaySmall?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat("EEEE").format(today),
              style: textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            homeTasksAsync.when(
              data: (tasks) {
                ref
                    .read(crashReporterProvider)
                    .log("home_page.dart > tasks length: ${tasks.length}");
                return Expanded(
                  child: tasks.isEmpty
                      ? Center(child: Text(context.l10n.commonNoResults))
                      : ListView.separated(
                          padding: const .only(bottom: 80),
                          itemBuilder: (_, i) => HomeTaskItem(
                            taskId: tasks[i].id,
                            onTap: () => context.push(
                              TaskDetailsPage.routeName,
                              extra: tasks[i].id,
                            ),
                          ),
                          itemCount: tasks.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 12),
                        ),
                );
              },
              error: (_, _) => Center(child: Text(context.l10n.homeListError)),
              loading: () => const Expanded(
                child: Center(child: CircularProgressIndicator.adaptive()),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Platform.isAndroid
          ? FloatingActionButton(
              onPressed: () => _showNewTaskBottomSheet(context),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  void _showNewTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => const NewTaskEditBottomSheet(),
    );
  }
}
