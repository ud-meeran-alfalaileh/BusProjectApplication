import 'package:drive_app/src/config/sizes/size_box_extension.dart';
import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/feature/admin_statistics/controller/admin_statistics_controller.dart';
import 'package:drive_app/src/feature/profile/view/profile_text.dart';
import 'package:drive_app/src/feature/rides/view/add_rides_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminStatisticsPage extends StatelessWidget {
  const AdminStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminStatisticsController())..getAllRides();
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              buildHeader(context, "statistics".tr),
              SizedBox(
                width: context.screenWidth,
                height: context.screenHeight * .3,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: controller.completedRides.value.toDouble(),
                        title: '',
                        color: Colors.green,
                        radius: 50,
                      ),
                      PieChartSectionData(
                        value: controller.elseRides.value.toDouble(),
                        title: '',
                        color: Colors.black,
                        radius: 50,
                      ),
                      PieChartSectionData(
                        value: controller.rejectedRides.value.toDouble(),
                        title: '',
                        color: Colors.red,
                        radius: 50,
                      ),
                      PieChartSectionData(
                        value: (controller.accptedDriverRides.value).toDouble(),
                        title: '',
                        color: Colors.grey,
                        radius: 50,
                      ),
                      PieChartSectionData(
                        value: (controller.startedRides.value).toDouble(),
                        title: '',
                        color: Colors.blue,
                        radius: 50,
                      ),
                    ],
                    sectionsSpace: 3,
                    centerSpaceRadius: 60,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  5.0.kW,
                  ProfileText.thirdText(
                    "${"Total".tr} : ${controller.allRides.length} ",
                  ),
                  ProfileText.ssText(
                    "${"Accpted".tr}: ${controller.accptedDriverRides.value}",
                    Colors.grey,
                  ),
                  5.0.kW,
                ],
              ),
              20.0.kH,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
