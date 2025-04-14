import 'package:drive_app/src/config/sizes/size_box_extension.dart';
import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/core/utils/app_button.dart';
import 'package:drive_app/src/feature/location/controller/location_controller.dart';
import 'package:drive_app/src/feature/location/view/seet_screen.dart';
import 'package:drive_app/src/feature/rides/controller/user_rides_controller..dart';
import 'package:drive_app/src/feature/rides/model/rides_model.dart';
import 'package:drive_app/src/feature/rides/view/add_rides_page.dart';
import 'package:drive_app/src/feature/rides/view/riders_text.dart';
import 'package:drive_app/src/feature/tickets/view/widget/ticket_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class StudentAllRidesScreen extends StatelessWidget {
  const StudentAllRidesScreen({super.key, required this.dashboardController});
  final DashboardController dashboardController;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserRidesController())
      ..getAllRidesForUser(
        from: dashboardController.fromLocation.value ?? '',
        toLocation: dashboardController.toLocation.value ?? '',
        date: dashboardController.selectedDate.value,
      );
    // ;
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildHeader(context, "All Rides".tr),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Obx(
                  () => controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : controller.userRides.isEmpty &&
                              controller.otherRides.isEmpty
                          ? RidersText.titlShowText("No rides found.".tr)
                          : Column(
                              children: [
                                controller.userRides.isEmpty
                                    ? SizedBox()
                                    : Row(
                                        children: [
                                          RidersText.titlShowText(
                                              "matchSearch".tr),
                                        ],
                                      ),
                                controller.userRides.isEmpty
                                    ? Column(
                                        children: [
                                          40.0.kH,
                                          Center(
                                            child:
                                                RidersText.descriptionShowTitle(
                                                    "No rides found.".tr),
                                          ),
                                          40.0.kH,
                                        ],
                                      )
                                    : ListView.separated(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: controller.userRides.length,
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return 20.0.kH;
                                        },
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final ride =
                                              controller.userRides[index];
                                          return _buildTripContainer(
                                              ride,
                                              index,
                                              context,
                                              controller,
                                              "fromList");
                                        },
                                      ),
                                Row(
                                  children: [
                                    RidersText.titlShowText("otherRides".tr),
                                  ],
                                ),
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.otherRides.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return 20.0.kH;
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final ride = controller.otherRides[index];
                                    return _buildTripContainer(ride, index,
                                        context, controller, "other");
                                  },
                                ),
                              ],
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildTripContainer(RidesModel ride, int index,
      BuildContext context, UserRidesController controller, fromList) {
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
              CircleAvatar(
                  radius: 26,
                  backgroundColor: AppTheme.lightAppColors.background,
                  backgroundImage: AssetImage('assets/image/logo (2).png')),
              10.0.kW,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RidersText.mainText(ride.driver?.name ?? "Loading..."),
                  Row(
                    children: [
                      Icon(
                        Icons.timelapse_rounded,
                        color:
                            AppTheme.lightAppColors.black.withValues(alpha: .3),
                        size: 17,
                      ),
                      5.0.kW,
                      TicketText.secText(ride.startDate)
                    ],
                  )
                ],
              )
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
          ride.status == "Booked"
              ? SizedBox()
              : isLoadingStatus.value
                  ? CircularProgressIndicator()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        appButton(
                            onTap: () async {
                              await controller.getUserBooking();
                              final isEmpty = controller.allBookedRide
                                  .firstWhereOrNull(
                                      (book) => book.id == ride.id);
                              if (isEmpty != null) {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.error(
                                    message: 'This Ride Already booked'.tr,
                                  ),
                                );
                              } else {
                                Get.to(SeatLocationScreen(
                                  rideId: ride.id,
                                ));
                              }
                            },
                            title: "Book".tr,
                            width: context.screenWidth * .4,
                            color: AppTheme.lightAppColors.primary),
                      ],
                    ),
        ],
      ),
    );
  }
}
