import 'package:drive_app/src/config/sizes/size_box_extension.dart';
import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/feature/rides/controller/driver_rides_controller.dart';
import 'package:drive_app/src/feature/rides/view/driver_accpted_rides.dart';
import 'package:drive_app/src/feature/tickets/view/widget/ticket_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverHomePage extends StatelessWidget {
  const DriverHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final DriverRidesController controller = Get.put(DriverRidesController())
      ..getRideForToday();

    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: SafeArea(
        child: SizedBox(
          width: context.screenWidth,
          height: context.screenHeight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: context.screenWidth,
                  height: context.screenHeight * .3,
                  color: AppTheme.lightAppColors.primary,
                  child: Column(
                    children: [
                      (context.screenHeight * .05).kH,
                      Image.asset(
                        'assets/image/logo (2).png',
                        width: context.screenWidth * .3,
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Today's trips".tr,
                              style: TextStyle(
                                color: AppTheme.lightAppColors.background,
                                fontFamily: "Kanti",
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(
                                    DriverAccptedRides(controller: controller));
                              },
                              child: Text(
                                "see all".tr,
                                style: TextStyle(
                                  color: AppTheme.lightAppColors.background,
                                  fontFamily: "Kanti",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                20.0.kH,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Obx(
                    () => controller.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : controller.todayRides.isEmpty
                            ? Text('No Rides for today'.tr)
                            : ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.todayRides.length,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return 10.0.kH;
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return _buildTodayContainer(
                                      controller, index, context);
                                },
                              ),
                  ),
                ),
                50.0.kH,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildTodayContainer(
      DriverRidesController controller, int index, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightAppColors.black.withValues(alpha: .1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
          color: AppTheme.lightAppColors.background,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${"Ticket No.".tr}: #${controller.todayRides[index].rideId}"),
          Divider(),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.screenWidth * .5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TicketText.durationText("Boarding Point".tr),
                      TicketText.titlShowText(
                          controller.todayRides[index].source),
                      25.0.kH,
                      TicketText.durationText("Drop Point".tr),
                      TicketText.titlShowText(
                          controller.todayRides[index].destination),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  width: 2,
                  color: AppTheme.lightAppColors.black,
                ),
                SizedBox(
                  width: context.screenWidth * .2,
                  child: Column(
                    children: [
                      TicketText.titlShowText("From".tr),
                      TicketText.durationText(
                          controller.todayRides[index].startTime),
                      25.0.kH,
                      TicketText.titlShowText("To".tr),
                      TicketText.durationText(
                          controller.todayRides[index].endTime),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
