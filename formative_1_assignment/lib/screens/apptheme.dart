import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const ink = Color(0xFF151B19);
  static const inkSoft = Color(0xFF4B5A56);
  static const base = Color(0xFFEEF2F0);
  static const surface = Color(0xFFFFFFFF);
  static const line = Color(0xFFD8E2DF);

  static const primary = Color(0xFF0E5C56);
  static const primaryTint = Color(0xFFE3EEEC);

  static const amber = Color(0xFFE08E45);
  static const amberTint = Color(0xFFFBEEE0);

  static const coral = Color(0xFFD6675B);
  static const coralTint = Color(0xFFFBEAE8);

  static const green = Color(0xFF2F9E64);
  static const greenTint = Color(0xFFE4F4EB);

  static const slate = Color(0xFF5B6C86);
  static const slateTint = Color(0xFFE7EAEF);
}

/// Role -> accent color mapping, used on team member rows and profile.
class RoleColor {
  final Color color;
  final Color tint;
  const RoleColor(this.color, this.tint);

  static const projectManager = RoleColor(AppColors.primary, AppColors.primaryTint);
  static const designer = RoleColor(AppColors.amber, AppColors.amberTint);
  static const developer = RoleColor(AppColors.slate, AppColors.slateTint);
  static const qa = RoleColor(AppColors.coral, AppColors.coralTint);
  static const docs = RoleColor(AppColors.green, AppColors.greenTint);
}

class AppText {
  static TextStyle get head => GoogleFonts.manrope(
        fontWeight: FontWeight.w800,
        color: AppColors.ink,
      );

  static TextStyle get headSemi => GoogleFonts.manrope(
        fontWeight: FontWeight.w700,
        color: AppColors.ink,
      );

  static TextStyle get body => GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        color: AppColors.ink,
      );

  static TextStyle get bodySoft => GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        color: AppColors.inkSoft,
      );
}

ThemeData buildAppTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.base,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.amber,
    ),
    fontFamily: GoogleFonts.inter().fontFamily,
    useMaterial3: true,
  );
}