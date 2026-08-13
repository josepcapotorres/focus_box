import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_box/features/focus_mode/presentation/providers/do_not_disturb_provider.dart';

class FocusPrimaryButton extends ConsumerStatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const FocusPrimaryButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  ConsumerState<FocusPrimaryButton> createState() => _FocusPrimaryButtonState();
}

class _FocusPrimaryButtonState extends ConsumerState<FocusPrimaryButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: .98,
      upperBound: 1.02,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final enabled = ref.watch(doNotDisturbProvider).value ?? false;

    if (enabled) {
      controller.repeat(reverse: true);
    } else {
      controller.stop();
      controller.value = 1;
    }

    final colorScheme = Theme.of(context).colorScheme;

    return ScaleTransition(
      scale: controller,
      child: FilledButton(
        style: FilledButton.styleFrom(
          shape: const CircleBorder(),
          minimumSize: const Size.square(88),
          backgroundColor: colorScheme.primary,
        ),
        onPressed: widget.onPressed,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          child: Icon(widget.icon, key: ValueKey(widget.icon), size: 42),
        ),
      ),
    );
  }
}
