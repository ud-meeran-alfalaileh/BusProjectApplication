import 'package:drive_app/src/config/sizes/size_box_extension.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:flutter/material.dart';

class ProfileText {
  static mainText(title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 25,
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
        color: AppTheme.lightAppColors.mainTextcolor.withValues(alpha: 0.8),
        fontWeight: FontWeight.w500, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static thirdText(title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 16,
        color: AppTheme.lightAppColors.mainTextcolor.withValues(alpha: 0.8),
        fontWeight: FontWeight.w500, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static ssText(title, color) {
    return Row(
      children: [
        Container(width: 10, height: 10, color: color),
        10.0.kW,
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Kanti',
            fontSize: 16,
            color: AppTheme.lightAppColors.mainTextcolor.withValues(alpha: 0.8),
            fontWeight:
                FontWeight.w500, // Use FontWeight.bold for the bold variant
          ),
        ),
      ],
    );
  }

  static boldText(title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 17,
        color: AppTheme.lightAppColors.mainTextcolor.withValues(alpha: 0.8),
        fontWeight: FontWeight.w500, // Use FontWeight.bold for the bold variant
      ),
    );
  }
}
