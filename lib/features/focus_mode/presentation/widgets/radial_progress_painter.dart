import 'dart:math' show pi;

import 'package:flutter/material.dart';

class RadialProgressPainter extends CustomPainter {
  const RadialProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.progressColor,
    required this.strokeCap,
    required this.startAngle,
  });

  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;
  final StrokeCap strokeCap;
  final double startAngle;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap;

    canvas.drawArc(
      rect.deflate(strokeWidth / 2),
      0,
      2 * pi,
      false,
      backgroundPaint,
    );

    canvas.drawArc(
      rect.deflate(strokeWidth / 2),
      startAngle,
      2 * pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(RadialProgressPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        strokeWidth != oldDelegate.strokeWidth ||
        backgroundColor != oldDelegate.backgroundColor ||
        progressColor != oldDelegate.progressColor ||
        strokeCap != oldDelegate.strokeCap ||
        startAngle != oldDelegate.startAngle;
  }
}
