import 'package:drive_app/src/config/theme/theme.dart';
import 'package:flutter/material.dart';

class TicketText {
  static mainText(title) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 15,
        color: AppTheme.lightAppColors.mainTextcolor,
        fontWeight: FontWeight.w400, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static secText(title) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 14,
        color: AppTheme.lightAppColors.black.withValues(alpha: .3),
        fontWeight: FontWeight.w400, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static timeText(title) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 16,
        color: AppTheme.lightAppColors.mainTextcolor,
        fontWeight: FontWeight.w400, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static ttText(title) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 16,
        color: AppTheme.lightAppColors.black.withValues(alpha: 0.2),
        fontWeight: FontWeight.w400, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static durationText(title) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 16,
        color: AppTheme.lightAppColors.mainTextcolor.withValues(alpha: .5),
        fontWeight: FontWeight.w400, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static titlShowText(title) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 16,
        color: AppTheme.lightAppColors.mainTextcolor,
        fontWeight: FontWeight.w600, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static descriptionShowTitle(title) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 13,
        color: AppTheme.lightAppColors.mainTextcolor,
        fontWeight: FontWeight.w600, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static notificationText(title) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 17,
        color: AppTheme.lightAppColors.mainTextcolor.withValues(alpha: 0.8),
        fontWeight: FontWeight.w600, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static chatText(title) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 15,
        color: AppTheme.lightAppColors.black,
        fontWeight: FontWeight.w300, // Use FontWeight.bold for the bold variant
      ),
    );
  }

  static headerText(title) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Kanti',
        fontSize: 17,
        color: AppTheme.lightAppColors.black,
        fontWeight: FontWeight.w600, // Use FontWeight.bold for the bold variant
      ),
    );
  }
}
