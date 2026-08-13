import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/entities/task.dart';
import '../../../../core/widgets/task_status_chip.dart';
import '../../../home/presentation/providers/home_tasks_provider.dart';
import '../widgets/do_not_disturb.dart';
import '../widgets/focus_footer.dart';
import '../widgets/radial_clock.dart';

class FocusModePage extends ConsumerWidget {
  static const routeName = "/focus_mode";

  final String taskId;

  const FocusModePage(this.taskId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = ColorScheme.of(context);

    final task = ref.watch(currentTaskProvider(taskId));

    if (task == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator.adaptive()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Modo enfoque", style: textTheme.headlineMedium),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 8),
              _Header(task),
              const SizedBox(height: 24),
              if (task.status != .completed) const DoNotDisturbCard(),
              const SizedBox(height: 32),
              if (task.status != .completed)
                const Expanded(child: Center(child: RadialClock())),
              const SizedBox(height: 32),
              if (task.status != .completed) const FocusFooter(),
              if (task.status == .completed) ...[
                Icon(
                  Icons.check_circle_rounded,
                  color: colorScheme.secondary,
                  size: 200,
                ),
                Text("¡Tarea finalizada!", style: textTheme.headlineMedium),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final Task task;

  const _Header(this.task);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          task.name,
          style: textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 8),

        TaskStatusChip(status: task.status),
      ],
    );
  }
}
