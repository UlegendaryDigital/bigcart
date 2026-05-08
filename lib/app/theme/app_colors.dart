import 'package:flutter/painting.dart';

/// Brand color tokens. Use these instead of hardcoding hex values.
abstract class AppColors {
  // Backgrounds
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundAlt = Color(0xFFF4F5F9);
  static const Color backgroundMuted = Color(0xFFF5F5F5);

  // Text
  static const Color text = Color(0xFF000000);
  static const Color textMuted = Color(0xFF868889);

  // Link
  static const Color link = Color(0xFF1A0DAB);

  // Border
  static const Color border = Color(0xFFEBEBEB);

  // Primary scale
  static const Color primary = Color(0xFFAEDC81);
  static const Color primaryDark = Color(0xFF6CC51D);
  static const Color primaryLight = Color(0xFFEBFFD7);
}
