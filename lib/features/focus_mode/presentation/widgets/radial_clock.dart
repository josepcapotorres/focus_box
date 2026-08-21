import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/duration_formatting_extension.dart';
import '../../../../core/extensions/translations_extension.dart';
import '../../../../core/providers/ticker_provider.dart';
import '../../../home/presentation/providers/home_tasks_provider.dart';
import '../providers/focus_session_provider.dart';
import 'radial_progress.dart';

class RadialClock extends ConsumerStatefulWidget {
  const RadialClock({super.key});

  @override
  RadialClockState createState() => RadialClockState();
}

class RadialClockState extends ConsumerState<RadialClock> {
  @override
  void initState() {
    super.initState();

    ref.listenManual(focusSessionProvider, (prev, next) {
      if (prev == null || next == null) return;

      if (prev.status != .completed && next.status == .completed) {
        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.focusModeTaskFinishSuccess)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    final session = ref.watch(focusSessionProvider);

    if (session == null) {
      return const SizedBox.shrink();
    }

    final task = ref.watch(currentTaskProvider(session.taskId));
    final timeTotal = task?.timeTotal ?? Duration.zero;

    final elapsed = ref.watch(tickerProvider);
    final progress = elapsed.progressOutOfTen(timeTotal) / 100;
    final exceeded = session.status == .exceeded;
    final progressColor = exceeded ? colorScheme.error : colorScheme.primary;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 250),
              tween: Tween(begin: 14, end: 18),
              builder: (_, lineWidth, _) {
                return RadialProgress(
                  progress: progress.clamp(0, 1),
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  progressColor: progressColor,
                  strokeWidth: lineWidth,
                  child: const _CenterClock(),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          Text(
            context.l10n.focusModeGoal(timeTotal.toHoursMinutesSeconds()),
            style: textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}

class _CenterClock extends ConsumerWidget {
  const _CenterClock();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = TextTheme.of(context);

    final session = ref.watch(focusSessionProvider);

    final exceeded = session?.status == .exceeded;
    final task = ref.read(currentTaskProvider(session?.taskId));

    final elapsed = ref.watch(tickerProvider);

    final timeTotal = (task?.timeTotal ?? Duration.zero);

    final remaining = timeTotal >= elapsed
        ? timeTotal - elapsed
        : Duration.zero;

    final remainingText = remaining.toHoursMinutesSeconds();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: Text(
            elapsed.toHoursMinutesSeconds(),
            key: ValueKey(elapsed),
            style: textTheme.displayLarge,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          exceeded
              ? context.l10n.focusModeExtraTime
              : context.l10n.focusModeRemaining,
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 2),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: Text(
            remainingText,
            key: ValueKey(remainingText),
            style: textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }
}
