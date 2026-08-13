import 'dart:ui' show Color;

import '../../../../core/themes/app_colors.dart';

enum TaskStatus {
  inProgress("En progreso", AppColors.primary, AppColors.inProgressContainer),
  completed("Completado", AppColors.secondary, AppColors.completedContainer),
  paused("Pausado", AppColors.paused, AppColors.pausedContainer),
  exceeded("Excedido", AppColors.warning, AppColors.warningContainer),
  pending("Pendiente", AppColors.paused, AppColors.pausedContainer);

  final String label;
  final Color foregroundColor;
  final Color backgroundColor;

  const TaskStatus(this.label, this.foregroundColor, this.backgroundColor);
}
