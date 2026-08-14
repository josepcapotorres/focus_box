import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_box/core/domain/enums/task_status.dart';
import 'package:focus_box/features/task_details/domain/entities/task_history_entry.dart';
import 'package:focus_box/features/task_details/presentation/providers/task_details_history_provider.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../core/extensions/duration_formatting_extension.dart';

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
          return const SizedBox(
            height: boxHeight,
            child: Center(child: Text("Aún no se ha iniciado la tarea")),
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
      error: (_, _) => const SizedBox(
        height: boxHeight,
        child: Center(child: Text("Error al obtener las líneas de tiempo")),
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
                _showShortDescriptionFromStatus(entries, currentEntry),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _showShortDescriptionFromStatus(
    List<TaskHistoryEntry> entries,
    TaskHistoryEntry currentElement,
  ) {
    final currentElementPositionFromList = entries.indexOf(currentElement);

    if (currentElementPositionFromList == 0) {
      return "Inicio de la tarea";
    }

    final timestampLastEvent =
        entries[currentElementPositionFromList - 1].timestamp;
    final timestampCurrentEvent =
        entries[currentElementPositionFromList].timestamp;
    final difference = timestampCurrentEvent.difference(timestampLastEvent);

    return switch (currentElement.toStatus) {
      TaskStatus.inProgress => "En progreso",
      TaskStatus.completed => "Completada",
      TaskStatus.paused => "Pausa (${difference.timeLineStepText()})",
      TaskStatus.exceeded => "Completada con más tiempo del calculado",
      TaskStatus.pending => "Pendiente",
    };
  }
}
