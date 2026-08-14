import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/managers/crash_reporter.dart';
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
                notifier.resume();
              }
            },
          ),

          FocusSecondaryButton(
            icon: Icons.check_rounded,
            color: colorScheme.secondary,
            label: "Finalizar",
            onPressed: () => _finishTask(context, ref),
          ),
        ],
      ),
    );
  }

  Future<void> _finishTask(BuildContext context, WidgetRef ref) async {
    if (!context.mounted) {
      ref
          .read(crashReporterProvider)
          .log("focus_footer.dart > _finishTask. context is not mounted");
      return;
    }

    await showAdaptiveDialog(
      context: context,
      builder: (_) => const _FinishTaskAlertDialog(),
    );
  }
}

class _FinishTaskAlertDialog extends ConsumerWidget {
  const _FinishTaskAlertDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text("Tarea finalizada"),
      content: const Text("¿Has acabado la tarea antes de tiempo?"),
      actions: [
        TextButton(onPressed: context.pop, child: const Text("Cancelar")),
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
