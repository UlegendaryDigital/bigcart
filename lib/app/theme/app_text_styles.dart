import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized typography for the app. All styles use Poppins.
///
/// Naming convention: `<role><Weight><Size>` — e.g. `titleBold20`,
/// `paragraphMedium12`, `labelMedium15`.
abstract class AppTextStyles {
  static TextStyle _poppins({
    required double fontSize,
    required FontWeight fontWeight,
    double? height,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
    );
  }

  // ---------- Title · Bold ----------
  static TextStyle get titleBold15 =>
      _poppins(fontSize: 15, fontWeight: FontWeight.w700);
  static TextStyle get titleBold20 =>
      _poppins(fontSize: 20, fontWeight: FontWeight.w700);
  static TextStyle get titleBold25 =>
      _poppins(fontSize: 25, fontWeight: FontWeight.w700);
  static TextStyle get titleBold30 =>
      _poppins(fontSize: 30, fontWeight: FontWeight.w700);

  // ---------- Title · SemiBold ----------
  static TextStyle get titleSemiBold15 =>
      _poppins(fontSize: 15, fontWeight: FontWeight.w600);
  static TextStyle get titleSemiBold20 =>
      _poppins(fontSize: 20, fontWeight: FontWeight.w600);
  static TextStyle get titleSemiBold25 =>
      _poppins(fontSize: 25, fontWeight: FontWeight.w600);
  static TextStyle get titleSemiBold30 =>
      _poppins(fontSize: 30, fontWeight: FontWeight.w600);

  // ---------- Paragraph · Regular ----------
  static TextStyle get paragraphRegular15 =>
      _poppins(fontSize: 15, fontWeight: FontWeight.w400, height: 1.5);

  // ---------- Paragraph · Medium ----------
  static TextStyle get paragraphMedium10 =>
      _poppins(fontSize: 10, fontWeight: FontWeight.w500, height: 1.5);
  static TextStyle get paragraphMedium12 =>
      _poppins(fontSize: 12, fontWeight: FontWeight.w500, height: 1.5);
  static TextStyle get paragraphMedium15 =>
      _poppins(fontSize: 15, fontWeight: FontWeight.w500, height: 1.5);

  // ---------- Label · Medium ----------
  static TextStyle get labelMedium12 =>
      _poppins(fontSize: 12, fontWeight: FontWeight.w500);
  static TextStyle get labelMedium15 =>
      _poppins(fontSize: 15, fontWeight: FontWeight.w500);
}
