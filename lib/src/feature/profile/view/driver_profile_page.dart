import 'package:drive_app/src/config/localization/lang_list.dart';
import 'package:drive_app/src/config/localization/locale_constant.dart';
import 'package:drive_app/src/config/sizes/size_box_extension.dart';
import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/core/user.dart';
import 'package:drive_app/src/core/utils/loading_page.dart';
import 'package:drive_app/src/feature/login/view/pages/login_page.dart';
import 'package:drive_app/src/feature/profile/contorller/driver_profile_controller.dart';
import 'package:drive_app/src/feature/profile/view/profile_text.dart';
import 'package:drive_app/src/feature/rides/view/add_rides_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverProfilePage extends StatelessWidget {
  const DriverProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localController = Get.put(LocalizationController());

    final controller = Get.put(DriverProfileController())..getAllRides();
    User user = User();
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? loadingPage(context)
              : Column(
                  children: [
                    buildHeader(context, "Profile".tr),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: AppTheme
                                              .lightAppColors.background,
                                          title: Text("Select Language".tr),
                                          content: Text(
                                              "Choose a language for your Application."
                                                  .tr),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                localController.updateLanguage(
                                                    Languages.locale[1]
                                                        ['locale']);

                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "Arabic".tr,
                                                style: TextStyle(
                                                    color: AppTheme
                                                        .lightAppColors.black),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                localController.updateLanguage(
                                                    Languages.locale[0]
                                                        ['locale']);
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "English".tr,
                                                style: TextStyle(
                                                    color: AppTheme
                                                        .lightAppColors.black),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.language_sharp)),
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
                                    "${"Name".tr}: ${controller.driverProfile.value!.name}"),
                                10.0.kH,
                                ProfileText.secText(
                                    "${"Email".tr}: ${controller.driverProfile.value!.email}"),
                                10.0.kH,
                                Row(
                                  children: [
                                    controller.driverProfile.value!.gender ==
                                            "male"
                                        ? Icon(
                                            Icons.male,
                                            color:
                                                AppTheme.lightAppColors.primary,
                                          )
                                        : Icon(
                                            Icons.female,
                                            color: AppTheme
                                                .lightAppColors.thirdTextcolor,
                                          ),
                                    5.0.kW,
                                    ProfileText.secText(
                                        "${"Gender".tr}: ${controller.driverProfile.value!.gender.tr}"),
                                  ],
                                ),
                                10.0.kH,
                              ],
                            ),
                          ),
                          20.0.kH,
                          Container(
                            padding: EdgeInsets.all(20),
                            width: context.screenWidth,
                            decoration: BoxDecoration(
                              color: AppTheme.lightAppColors.background,
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.lightAppColors.black
                                      .withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Left: Text or stats
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ProfileText.thirdText(
                                      "${"Total".tr} : ${controller.allRides.length} ${"RidesCount".tr}",
                                    ),
                                    5.0.kH,
                                    ProfileText.ssText(
                                      "${"Accpted".tr}: ${controller.accptedDriverRides.value}",
                                      Colors.grey,
                                    ),
                                    5.0.kH,
                                    ProfileText.ssText(
                                      "${"Rejected".tr}: ${controller.rejectedRides.value}",
                                      Colors.red,
                                    ),
                                    5.0.kH,
                                    ProfileText.ssText(
                                      "${"In Progress".tr}: ${controller.startedRides.value}",
                                      Colors.blue,
                                    ),
                                    5.0.kH,
                                    ProfileText.ssText(
                                      "${"Done".tr}: ${controller.completedRides.value}",
                                      Colors.green,
                                    ),
                                    5.0.kH,
                                  ],
                                ),

                                // Right: Pie Chart
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: PieChart(
                                    //
                                    PieChartData(
                                      sections: [
                                        //    completes
                                        PieChartSectionData(
                                          value: controller.completedRides.value
                                              .toDouble(),
                                          title: '',
                                          color: Colors.green,
                                          radius: 30,
                                        ),
                                        //rejectedRides
                                        PieChartSectionData(
                                          value: controller.rejectedRides.value
                                              .toDouble(),
                                          title: '',
                                          color: Colors.red,
                                          radius: 30,
                                        ),
                                        //  accptedDriverRides
                                        PieChartSectionData(
                                          value: (controller
                                                  .accptedDriverRides.value)
                                              .toDouble(),
                                          title: '',
                                          color: Colors.grey,
                                          radius: 30,
                                        ),
                                        //  startedRides

                                        PieChartSectionData(
                                          value: (controller.startedRides.value)
                                              .toDouble(),
                                          title: '',
                                          color: Colors.blue,
                                          radius: 30,
                                        ),
                                      ],
                                      sectionsSpace: 2,
                                      centerSpaceRadius: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
