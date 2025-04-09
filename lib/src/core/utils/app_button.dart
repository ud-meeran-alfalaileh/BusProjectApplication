import 'package:drive_app/src/config/theme/theme.dart';
import 'package:flutter/material.dart';

appButton({
  required VoidCallback onTap,
  required String title,
  required double width,
  Color? color,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: color ?? AppTheme.lightAppColors.bordercolor,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: color == null
                  ? AppTheme.lightAppColors.mainTextcolor
                  : Colors.white,
              fontFamily: "Kanti",
              fontSize: 17),
        ),
      ),
    ),
  );
}
