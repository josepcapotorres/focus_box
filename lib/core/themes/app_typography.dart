import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  const AppTypography._();

  static TextTheme buildTextTheme({
    required Color primaryColor,
    required Color secondaryColor,
  }) {
    return GoogleFonts.interTextTheme().copyWith(
      // ===========================
      // HOME
      // ===========================

      // Hoy
      displaySmall: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.15,
        color: primaryColor,
      ),

      // Títulos de secciones / AppBar
      headlineMedium: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: primaryColor,
      ),
      headlineSmall: GoogleFonts.inter(fontSize: 24, color: primaryColor),
      titleLarge: GoogleFonts.inter(fontSize: 22, color: primaryColor),
      // Nombre tarea
      titleMedium: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),

      // Fecha · Viernes
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
      ),

      // ===========================
      // FOCUS PLAYER
      // ===========================

      // Cronómetro
      displayLarge: GoogleFonts.inter(
        fontSize: 52,
        fontWeight: FontWeight.w700,
        letterSpacing: -1,
        color: primaryColor,
      ),

      // Tiempo restante
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),

      // Texto secundario
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: primaryColor,
      ),

      // Tiempo tarjetas
      bodySmall: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
      ),

      // ===========================
      // CHIPS
      // ===========================
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),

      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: secondaryColor,
      ),

      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
      ),
    );
  }
}
