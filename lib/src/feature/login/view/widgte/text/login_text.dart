import 'package:drive_app/src/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginText {
  static haveAccount(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(TextSpan(
          text: 'dontHaveAccoint'.tr,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Kanti',
            color: AppTheme.lightAppColors.mainTextcolor,
          ),
          children: [
            TextSpan(
              text: "Sign up".tr,
              style: TextStyle(
                fontSize: 15,
                color: AppTheme.lightAppColors.primary,
                fontFamily: 'Kanti',
              ),
            )
          ])),
    );
  }

  static dontHaveAccount(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(TextSpan(
          text: "HaveAccount".tr,
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Kanti',
            color: AppTheme.lightAppColors.mainTextcolor,
          ),
          children: [
            TextSpan(
              text: "Sign In".tr,
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.lightAppColors.primary,
                fontFamily: 'Kanti',
              ),
            )
          ])),
    );
  }

  static mainText(title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 30,
        letterSpacing: 2,
        color: AppTheme.lightAppColors.mainTextcolor.withValues(alpha: 0.8),
        fontWeight: FontWeight.w500, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static secText(title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 15,
        color: AppTheme.lightAppColors.mainTextcolor.withValues(alpha: 0.4),
        fontWeight: FontWeight.w600, // Use FontWeight.bold for the bold variant
      ),
    );
  }
}
