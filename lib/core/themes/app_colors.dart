import 'package:flutter/material.dart' show Color, Colors;

class AppColors {
  // ===========================================================================
  // BRAND
  // ===========================================================================

  static const primary = Color(0xFF6366F1);
  static const primaryDark = Color(0xFF818CF8);

  static const primaryContainer = Color(0xFFE0E7FF);
  static const primaryContainerDark = Color(0xFF312E81);

  static const secondary = Color(0xFF10B981);
  static const secondaryDark = Color(0xFF34D399);

  static const secondaryContainer = Color(0xFFECFDF5);
  static const onSecondaryContainer = Color(0xFF065F46);

  static const secondaryContainerDark = Color(0xFFECFDF5);

  // ===========================================================================
  // STATUS
  // ===========================================================================

  static const warning = Color(0xFFF59E0B);

  static const error = Color(0xFFEF4444);

  static const info = Color(0xFF3B82F6);

  // ===========================================================================
  // LIGHT
  // ===========================================================================

  static const backgroundLight = Color(0xFFF8FAFC);

  static const surfaceLight = Colors.white;

  static const surfaceVariantLight = Color(0xFFF1F5F9);

  static const borderLight = Color(0xFFE2E8F0);

  static const textPrimaryLight = Color(0xFF0F172A);

  static const textSecondaryLight = Color(0xFF64748B);

  // ===========================================================================
  // DARK
  // ===========================================================================

  static const backgroundDark = Color(0xFF0F172A);

  static const surfaceDark = Color(0xFF1E293B);

  static const surfaceVariantDark = Color(0xFF334155);

  static const borderDark = Color(0xFF334155);

  static const textPrimaryDark = Color(0xFFF8FAFC);

  static const textSecondaryDark = Color(0xFF94A3B8);

  // ===========================================================================
  // TASK STATUS
  // ===========================================================================

  static const inProgressContainer = Color(0xFFEEF2FF);
  static const completedContainer = Color(0xFFECFDF5);
  static const paused = Color(0xFF64748B);
  static const pausedContainer = surfaceVariantLight;
  static const warningContainer = Color(0xFFFEF2F2);

  static const chartEstimated = Color(0xFFA5B4FC);
}
