import 'package:drive_app/src/config/sizes/size_box_extension.dart';
import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/core/user.dart';
import 'package:drive_app/src/feature/login/view/pages/login_page.dart';
import 'package:drive_app/src/feature/profile/contorller/admin_profile_controller.dart';
import 'package:drive_app/src/feature/profile/view/profile_text.dart';
import 'package:drive_app/src/feature/rides/view/add_rides_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminProfileController());
    User user = User();
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(context, "Profile".tr),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            user.clearId();
                            Get.offAll(LoginPage());
                          },
                          child: Icon(Icons.logout)),
                    ],
                  ),
                  10.0.kH,
                  Container(
                    padding: EdgeInsets.all(20),
                    width: context.screenWidth,
                    decoration: BoxDecoration(
                        color: AppTheme.lightAppColors.background,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.lightAppColors.black
                                .withValues(alpha: .1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileText.mainText(
                            "${"Name".tr}: ${controller.adminProfile.value!.name}"),
                        10.0.kH,
                        ProfileText.secText(
                            "${"Email".tr}: ${controller.adminProfile.value!.email}"),
                        10.0.kH,
                        Row(
                          children: [
                            controller.adminProfile.value!.gender == "male"
                                ? Icon(
                                    Icons.male,
                                    color: AppTheme.lightAppColors.primary,
                                  )
                                : Icon(
                                    Icons.female,
                                    color:
                                        AppTheme.lightAppColors.thirdTextcolor,
                                  ),
                            5.0.kW,
                            ProfileText.thirdText(
                                "${"Gender".tr}: ${controller.adminProfile.value!.gender}"),
                          ],
                        ),
                        10.0.kH,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
