import 'package:drive_app/src/config/sizes/size_box_extension.dart';
import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/feature/admin_statistics/view/admin_statistics_page.dart';
import 'package:drive_app/src/feature/profile/contorller/admin_profile_controller.dart';
import 'package:drive_app/src/feature/profile/view/admin_profile_page.dart';
import 'package:drive_app/src/feature/rides/view/add_rides_page.dart';
import 'package:drive_app/src/feature/rides/view/all_rides_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(AdminProfileController());
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Obx(
          () => profileController.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      _buildHomeHeader(profileController),
                      20.0.kH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildHomeButton(
                            context,
                            () {
                              Get.to(() => AllRidesScreen());
                            },
                            "Rides".tr,
                            "assets/image/busIcon.png",
                            AppTheme.lightAppColors.primary,
                          ),
                          _buildHomeButton(context, () {
                            Get.to(() => AdminStatisticsPage());
                          }, "Statistics".tr, "assets/image/pie-cart.png",
                              null),
                          _buildHomeButton(context, () {
                            Get.to(() => AddRidesPage());
                          }, "Add Rides".tr, "assets/image/add-square-02.png",
                              Color(0xffEF9A9A)),
                        ],
                      ),
                      20.0.kH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildHomeButton(context, () {
                            Get.to(() => AdminProfilePage());
                          }, "Profile".tr, "assets/image/user.png",
                              Colors.blueAccent),
                        ],
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  GestureDetector _buildHomeButton(BuildContext context, VoidCallback onTap,
      String title, String icon, Color? color) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: context.screenWidth * 0.26, // Set a specific width
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppTheme.lightAppColors.background),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  icon,
                  color: color,
                  height: context.screenHeight * .035,
                ),
                8.0.kH,
                Text(
                  title,
                  style: TextStyle(
                      color: AppTheme.lightAppColors.primary,
                      fontFamily: "Kanti",
                      fontSize: 14),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildHomeHeader(AdminProfileController profileController) {
    return Row(
      children: [
        Image.asset("assets/image/logo (2).png"),
        Text(
          "${"Hey".tr} ${profileController.adminProfile.value!.name}!",
          style: TextStyle(
              color: AppTheme.lightAppColors.primary,
              fontFamily: "Kanti",
              fontSize: 20,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
