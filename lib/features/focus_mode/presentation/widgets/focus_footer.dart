import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/managers/crash_reporter.dart';
import '../../../task_details/domain/entities/task_history_entry.dart';
import '../../../task_details/presentation/providers/task_details_history_provider.dart';
import '../providers/focus_session_provider.dart';
import 'focus_primary_button.dart';
import 'focus_secondary_button.dart';

class FocusFooter extends ConsumerWidget {
  const FocusFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final session = ref.watch(focusSessionProvider);

    if (session == null) {
      return const SizedBox.shrink();
    }

    final running = session.status == .inProgress;

    return SafeArea(
      top: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FocusSecondaryButton(
            icon: Icons.add,
            label: "+15 min",
            onPressed: () {
              ref.read(focusSessionProvider.notifier).add15minToTotal();

              ref
                  .read(crashReporterProvider)
                  .log("focus_footer.dart > +15min btn");
            },
          ),

          FocusPrimaryButton(
            icon: running ? Icons.pause_rounded : Icons.play_arrow_rounded,
            onPressed: () async {
              final notifier = ref.read(focusSessionProvider.notifier);

              ref.read(crashReporterProvider)
                ..log("focus_footer.dart > play / pause btn")
                ..setCustomKey("running", running ? "true" : "false");

              if (running) {
                notifier.pause();
              } else {
                notifier.resumeTimer();
              }
            },
          ),

          FocusSecondaryButton(
            icon: Icons.check_rounded,
            color: colorScheme.secondary,
            label: "Finalizar",
            onPressed: () async {
              await ref
                  .read(taskDetailsHistoryProvider.notifier)
                  .addEntry(
                    TaskHistoryEntry(
                      id: const Uuid().v4(),
                      taskId: session.taskId,
                      timestamp: DateTime.now(),
                      toStatus: .completed,
                    ),
                  );

              await _finishTask(context, ref, running);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _finishTask(
    BuildContext context,
    WidgetRef ref,
    bool running,
  ) async {
    await ref.read(focusSessionProvider.notifier).pause();

    if (!context.mounted) {
      ref
          .read(crashReporterProvider)
          .log("focus_footer.dart > _finishTask. context is not mounted");
      return;
    }

    ref.read(crashReporterProvider)
      ..log("focus_footer.dart > _finishTask()")
      ..setCustomKey("running", running ? "true" : "false");

    await showAdaptiveDialog(
      context: context,
      builder: (_) => _FinishTaskAlertDialog(
        onCancel: () {
          if (running) {
            ref.read(focusSessionProvider.notifier).pause();
          } else {
            ref.read(focusSessionProvider.notifier).resumeTimer();
          }
        },
      ),
    );
  }
}

class _FinishTaskAlertDialog extends ConsumerWidget {
  final VoidCallback onCancel;

  const _FinishTaskAlertDialog({required this.onCancel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text("Tarea finalizada"),
      content: const Text("¿Has acabado la tarea antes de tiempo?"),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
            onCancel();
          },
          child: const Text("Cancelar"),
        ),
        TextButton(
          onPressed: () {
            ref.read(focusSessionProvider.notifier).setToDone();
            context.pop();
          },
          child: const Text("Finalizar"),
        ),
      ],
    );
  }
}
