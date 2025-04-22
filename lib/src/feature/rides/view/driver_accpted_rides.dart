import 'package:drive_app/src/config/sizes/size_box_extension.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/core/utils/loading_page.dart';
import 'package:drive_app/src/feature/rides/controller/driver_rides_controller.dart';
import 'package:drive_app/src/feature/rides/model/rides_model.dart';
import 'package:drive_app/src/feature/rides/view/add_rides_page.dart';
import 'package:drive_app/src/feature/rides/view/riders_text.dart';
import 'package:drive_app/src/feature/tickets/view/widget/ticket_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverAccptedRides extends StatefulWidget {
  const DriverAccptedRides({super.key, required this.controller});
  final DriverRidesController controller;

  @override
  State<DriverAccptedRides> createState() => _DriverAccptedRidesState();
}

class _DriverAccptedRidesState extends State<DriverAccptedRides> {
  @override
  void initState() {
    super.initState();
    widget.controller.getRideForDrive();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: SafeArea(
        child: Obx(
          () => widget.controller.isLoading.value
              ? loadingPage(context)
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      buildHeader(context, "All Rides".tr),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.all(20),
                        itemCount: widget.controller.accptedDriverRides.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return 20.0.kH;
                        },
                        itemBuilder: (BuildContext context, int index) {
                          final ride =
                              widget.controller.accptedDriverRides[index];
                          return buildTripContainer(
                              ride, widget.controller, index, context);
                        },
                      ),
                      100.0.kH,
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

Container buildTripContainer(RidesModel ride, DriverRidesController controller,
    int index, BuildContext context) {
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
                RidersText.mainText(ride.name ?? "Loading..."),
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
                  color: AppTheme.lightAppColors.black.withValues(alpha: 0.3)),
            ),
            TicketText.durationText(ride.startTime),
            Text(
              'To'.tr,
              style: TextStyle(
                  fontFamily: "Kanti",
                  fontSize: 12,
                  color: AppTheme.lightAppColors.black.withValues(alpha: 0.3)),
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
        Obx(() => isLoadingStatus.value
            ? CircularProgressIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ride.status == "Accpted"
                      ? statusButton(
                          onTap: () {
                            controller.changeStatus(
                                ride.rideId, isLoadingStatus, index, "In Progress");
                          },
                          title: "Started".tr,
                          color: AppTheme.lightAppColors.primary)
                      : ride.status == "In Progress"
                          ? statusButton(
                              onTap: () {
                                controller.changeStatus(ride.rideId,
                                    isLoadingStatus, index, "Completed");
                              },
                              title: "Completed".tr,
                              color: AppTheme.lightAppColors.thirdTextcolor)
                          : GestureDetector(
                              onTap: () {
                                // controller.changeStatus(ride.id,
                                //     isLoadingStatus, index, "In Progress");
                              },
                              child: Text(ride.status.tr))
                ],
              ))
      ],
    ),
  );
}

statusButton({
  required VoidCallback onTap,
  required String title,
  required Color color,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: RidersText.buttonText(title),
    ),
  );
}
