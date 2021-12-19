library theme;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _baseTheme = ThemeData(
  textTheme: GoogleFonts.poppinsTextTheme(),
);

final lightTheme = _baseTheme.copyWith(
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal),
);
