import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/entities/task.dart';
import '../../../../core/extensions/translations_extension.dart';
import '../../../../core/themes/app_colors.dart';
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
        title: Text(
          context.l10n.focusModeTitle,
          style: textTheme.headlineMedium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 12),
          child: Column(
            children: [
              _Header(task),
              if (task.status != .completed && task.status != .exceeded) ...[
                const SizedBox(height: 16),
                const DoNotDisturbCard(),
              ],
              if (task.status != .completed && task.status != .exceeded) ...[
                const SizedBox(height: 16),
                const Expanded(child: Center(child: RadialClock())),
              ],
              const SizedBox(height: 12),
              if (task.status != .completed && task.status != .exceeded)
                const FocusFooter(),
              if (task.status == .completed) ...[
                Icon(
                  Icons.check_circle_rounded,
                  color: colorScheme.secondary,
                  size: 200,
                ),
                Text(
                  context.l10n.focusModeTaskFinished,
                  style: textTheme.headlineMedium,
                ),
              ] else if (task.status == .exceeded) ...[
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.warning,
                  size: 200,
                ),
                Text(
                  context.l10n.focusModeTaskFinished,
                  style: textTheme.headlineMedium,
                ),
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
