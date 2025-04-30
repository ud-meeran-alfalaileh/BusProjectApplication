import 'package:drive_app/src/config/sizes/size_box_extension.dart';
import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/feature/admin_statistics/controller/admin_statistics_controller.dart';
import 'package:drive_app/src/feature/profile/view/profile_text.dart';
import 'package:drive_app/src/feature/rides/model/rides_model.dart';
import 'package:drive_app/src/feature/rides/view/add_rides_page.dart';
import 'package:drive_app/src/feature/rides/view/riders_text.dart';
import 'package:drive_app/src/feature/tickets/view/widget/ticket_text.dart';
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
          () => SingleChildScrollView(
            child: Column(
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
                          value:
                              (controller.accptedDriverRides.value).toDouble(),
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
                30.0.kH,
                Row(
                  children: [
                    20.0.kW,
                    ProfileText.boldText("Most Booked Rides".tr),
                  ],
                ),
                10.0.kH,
                ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.mostBooked.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return 10.0.kH;
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return buildTripContainer(
                        controller.mostBooked[index], index, context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildTripContainer(
      RidesModel ride, int index, BuildContext context) {
    RxBool isLoadingStatus = false.obs;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppTheme.lightAppColors.containercolor),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.0.kW,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RidersText.mainText(
                      "${"Booking Count".tr} ${ride.bookingCount}"),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color:
                            AppTheme.lightAppColors.black.withValues(alpha: .3),
                        size: 17,
                      ),
                      5.0.kW,
                      TicketText.secText(ride.startDate)
                    ],
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
          10.0.kH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  TicketText.timeText(ride.source),
                  TicketText.ttText(ride.startTime),
                ],
              ),
              Text(
                'From'.tr,
                style: TextStyle(
                    fontFamily: "Kanti",
                    fontSize: 12,
                    color:
                        AppTheme.lightAppColors.black.withValues(alpha: 0.3)),
              ),
              TicketText.durationText(ride.startTime),
              Text(
                'To'.tr,
                style: TextStyle(
                    fontFamily: "Kanti",
                    fontSize: 12,
                    color:
                        AppTheme.lightAppColors.black.withValues(alpha: 0.3)),
              ),
              Column(
                children: [
                  TicketText.timeText(ride.destination),
                  TicketText.ttText(ride.endTime),
                ],
              ),
            ],
          ),
          10.0.kH,
        ],
      ),
    );
  }
}
