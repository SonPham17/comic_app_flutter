import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TvStyle {
  static TextStyle fontApp() => GoogleFonts.getFont('Sriracha');

  static TextStyle fontAppWithSize(double size) =>
      GoogleFonts.getFont('Sriracha', fontSize: size);

  static TextStyle fontAppWithCustom(
          {double size, Color color, FontWeight fontWeight,TextDecoration textDecoration}) =>
      GoogleFonts.getFont(
        'Sriracha',
        fontSize: size,
        color: color,
        decoration: textDecoration,
        fontWeight: fontWeight,
      );
}
