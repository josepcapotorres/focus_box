import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/translations_extension.dart';
import '../providers/do_not_disturb_provider.dart';
import '../providers/focus_session_provider.dart';

class DoNotDisturbCard extends ConsumerStatefulWidget {
  const DoNotDisturbCard({super.key});

  @override
  DoNotDisturbCardState createState() => DoNotDisturbCardState();
}

class DoNotDisturbCardState extends ConsumerState<DoNotDisturbCard>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final doNotDisturbEnabled = ref.watch(doNotDisturbProvider).value ?? false;

    final taskStatus = ref.watch(focusSessionProvider)?.status;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: doNotDisturbEnabled
            ? colorScheme.primaryContainer
            : colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: doNotDisturbEnabled
              ? colorScheme.primary
              : colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: doNotDisturbEnabled
                    ? colorScheme.primary
                    : colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Icon(
                  doNotDisturbEnabled
                      ? Icons.do_not_disturb_on
                      : Icons.bedtime_outlined,
                  key: ValueKey(doNotDisturbEnabled),
                  color: doNotDisturbEnabled
                      ? colorScheme.onPrimary
                      : colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doNotDisturbEnabled
                        ? context.l10n.focusModeDndActivated
                        : context.l10n.focusModeDndDeactivated,
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    context.l10n.focusModeDndSilenceResources,
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Switch.adaptive(
              value: doNotDisturbEnabled,
              onChanged: taskStatus != .completed
                  ? (newValue) {
                      if (newValue) {
                        ref.read(doNotDisturbProvider.notifier).enableDNDMode();
                      } else {
                        ref
                            .read(doNotDisturbProvider.notifier)
                            .disableDNDMode();
                      }
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(doNotDisturbProvider.notifier).refresh();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
