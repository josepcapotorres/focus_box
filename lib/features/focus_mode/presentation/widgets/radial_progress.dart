import 'dart:math' show pi;

import 'package:flutter/material.dart';

import 'radial_progress_painter.dart';

class RadialProgress extends StatelessWidget {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;
  final StrokeCap strokeCap;
  final double startAngle;
  final Widget? child;

  const RadialProgress({
    super.key,
    required this.progress,
    this.strokeWidth = 8,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.blue,
    this.strokeCap = StrokeCap.round,
    this.startAngle = -pi / 2,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: progress.clamp(0, 1)),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (_, animatedProgress, _) {
        return AspectRatio(
          aspectRatio: 1,
          child: CustomPaint(
            painter: RadialProgressPainter(
              progress: animatedProgress.clamp(0.0, 1.0),
              strokeWidth: strokeWidth,
              backgroundColor: backgroundColor,
              progressColor: progressColor,
              strokeCap: strokeCap,
              startAngle: startAngle,
            ),
            child: Center(child: child),
          ),
        );
      },
    );
  }
}
