import 'dart:ui' show Color;

import '../../../../core/themes/app_colors.dart';

enum TaskStatus {
  inProgress(AppColors.primary, AppColors.inProgressContainer),
  completed(AppColors.secondary, AppColors.completedContainer),
  paused(AppColors.paused, AppColors.pausedContainer),
  exceeded(AppColors.warning, AppColors.warningContainer),
  pending(AppColors.paused, AppColors.pausedContainer);

  final Color foregroundColor;
  final Color backgroundColor;

  const TaskStatus(this.foregroundColor, this.backgroundColor);
}
