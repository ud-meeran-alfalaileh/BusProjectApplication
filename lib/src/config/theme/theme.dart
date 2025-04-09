import 'package:flutter/material.dart';

import 'app_extension.dart';

class AppTheme {
  static final light = ThemeData.light().copyWith(
    extensions: [
      lightAppColors,
    ],
  );

  static final lightAppColors = AppColorsExtension(
    primary: const Color(0xff042F40), //
    background: const Color(0xffffffff), //
    black: const Color(0xff000000), //
    maincolor: const Color(0xffFAF7F0), //
    bordercolor: const Color(0xffdddddd),
    subTextcolor: const Color(0xff6B7280),
    mainTextcolor: const Color(0xff000000),
    thirdTextcolor: const Color(0xffEF9A9A),
    containercolor: const Color.fromARGB(203, 213, 213, 213),
    secondaryColor: const Color(0xffFAC763),
  );
}
