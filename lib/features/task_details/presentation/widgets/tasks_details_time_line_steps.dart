import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_box/core/extensions/translations_extension.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../core/domain/enums/task_status.dart';
import '../../../../core/extensions/duration_formatting_extension.dart';
import '../../domain/entities/task_history_entry.dart';
import '../providers/task_details_history_provider.dart';

class TasksDetailsTimeLineSteps extends ConsumerWidget {
  final String taskId;

  const TasksDetailsTimeLineSteps(this.taskId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskHistoryEntriesAsync = ref.watch(
      taskHistoryEntriesByTaskIdProvider(taskId),
    );

    const boxHeight = 100.0;

    return taskHistoryEntriesAsync.when(
      data: (entries) {
        if (entries.isEmpty) {
          return SizedBox(
            height: boxHeight,
            child: Center(
              child: Text(context.l10n.taskDetailsTaskNotStartedYet),
            ),
          );
        }

        final sortedEntriesByDate = _sortEntriesByDate(entries);

        return Column(
          children: sortedEntriesByDate
              .map(
                (e) => _TimeLineTile(
                  entries: sortedEntriesByDate,
                  currentPosition: sortedEntriesByDate.indexOf(e),
                ),
              )
              .toList(),
        );
      },
      error: (_, _) => SizedBox(
        height: boxHeight,
        child: Center(child: Text(context.l10n.taskDetailsTimelineError)),
      ),
      loading: () => const CircularProgressIndicator.adaptive(),
    );
  }

  List<TaskHistoryEntry> _sortEntriesByDate(List<TaskHistoryEntry> entries) {
    return entries..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }
}

class _TimeLineTile extends StatelessWidget {
  final List<TaskHistoryEntry> entries;
  final int currentPosition;

  const _TimeLineTile({required this.entries, required this.currentPosition});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final hmsDateFormat = DateFormat("HH:mm:ss");

    final currentEntry = entries[currentPosition];

    return TimelineTile(
      isFirst: currentPosition == 0,
      isLast: currentPosition == entries.length - 1,
      indicatorStyle: IndicatorStyle(
        width: 16,
        height: 16,
        indicator: Container(
          decoration: BoxDecoration(
            color: currentPosition == 0
                ? colorScheme.secondary
                : currentEntry.toStatus.foregroundColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
        ),
      ),
      beforeLineStyle: const LineStyle(color: Colors.indigo, thickness: 2),
      endChild: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          spacing: 32,
          children: [
            SizedBox(
              width: 65,
              child: Text(hmsDateFormat.format(currentEntry.timestamp)),
            ),
            Expanded(
              child: Text(
                _showShortDescriptionFromStatus(context, entries, currentEntry),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _showShortDescriptionFromStatus(
    BuildContext context,
    List<TaskHistoryEntry> entries,
    TaskHistoryEntry currentElement,
  ) {
    final currentElementPositionFromList = entries.indexOf(currentElement);

    if (currentElementPositionFromList == 0) {
      return context.l10n.taskDetailsStartTask;
    }

    final timestampLastEvent =
        entries[currentElementPositionFromList - 1].timestamp;
    final timestampCurrentEvent =
        entries[currentElementPositionFromList].timestamp;
    final difference = timestampCurrentEvent.difference(timestampLastEvent);

    return switch (currentElement.toStatus) {
      TaskStatus.inProgress => context.l10n.commonTaskInProgress,
      TaskStatus.completed => context.l10n.commonTaskCompleted,
      TaskStatus.paused => context.l10n.taskDetailsPauseDiff(
        difference.timeLineStepText(),
      ),
      TaskStatus.exceeded => context.l10n.taskDetailsCompletedExceededTime,
      TaskStatus.pending => context.l10n.commonTaskPending,
      TaskStatus.exceededInProgress =>
        context.l10n.taskDetailsExceededInProgress,
    };
  }
}
