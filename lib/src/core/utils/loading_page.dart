import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:flutter/material.dart';

Align loadingPage(BuildContext context) {
  return Align(
    alignment: Alignment.center,
    child: Container(
      width: context.screenWidth,
      height: context.screenHeight,
      color: AppTheme.lightAppColors.background,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: context.screenWidth * .3,
              height: context.screenHeight * .3,
              child: Image.asset("assets/image/logo (2).png"),
            ),
          ),
        ],
      ),
    ),
  );
}
