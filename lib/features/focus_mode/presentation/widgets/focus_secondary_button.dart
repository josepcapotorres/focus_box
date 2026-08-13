import 'package:flutter/material.dart';

class FocusSecondaryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? color;

  const FocusSecondaryButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final foreground = color ?? colorScheme.onSurfaceVariant;

    return Column(
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: const CircleBorder(),
            minimumSize: const Size.square(72),
            side: BorderSide(color: foreground),
            padding: EdgeInsets.zero,
          ),
          onPressed: onPressed,
          child: Icon(icon, color: foreground, size: 30),
        ),

        const SizedBox(height: 8),

        Text(label, style: textTheme.labelMedium),
      ],
    );
  }
}
