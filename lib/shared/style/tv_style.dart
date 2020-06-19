import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TvStyle {
  static TextStyle fontApp() => GoogleFonts.getFont('Pacifico');

  static TextStyle fontAppWithSize(double size) =>
      GoogleFonts.getFont('Pacifico', fontSize: size);

  static TextStyle fontAppWithCustom(
          {double size, Color color, FontWeight fontWeight,TextDecoration textDecoration}) =>
      GoogleFonts.getFont(
        'Pacifico',
        fontSize: size,
        color: color,
        decoration: textDecoration,
        fontWeight: fontWeight,
      );
}
