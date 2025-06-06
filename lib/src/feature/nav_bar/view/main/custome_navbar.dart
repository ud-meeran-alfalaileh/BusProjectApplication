import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomNavItem extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;
  final bool isSelected;

  const CustomNavItem({
    super.key,
    required this.icon,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: context.screenWidth * 0.2,
        height: context.screenHeight,
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            isSelected
                ? AppTheme.lightAppColors.primary
                : AppTheme.lightAppColors.black.withValues(alpha: .3),
            BlendMode.srcIn,
          ),
          child: icon,
        ),
      ),
    );
  }
}
