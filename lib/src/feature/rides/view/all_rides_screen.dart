import 'package:drive_app/src/config/sizes/size_box_extension.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/feature/rides/controller/rides_controller.dart';
import 'package:drive_app/src/feature/rides/model/rides_model.dart';
import 'package:drive_app/src/feature/rides/view/add_rides_page.dart';
import 'package:drive_app/src/feature/rides/view/riders_text.dart';
import 'package:drive_app/src/feature/tickets/view/widget/ticket_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllRidesScreen extends StatelessWidget {
  const AllRidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RidesController())..getAllRides();

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
                      : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.rides.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return 20.0.kH;
                          },
                          itemBuilder: (BuildContext context, int index) {
                            final ride = controller.rides[index];
                            return _buildTripContainer(
                                ride, controller, index, context);
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildTripContainer(RidesModel ride, RidesController controller,
      int index, BuildContext context) {
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
                      TicketText.secText(
                          "${"start".tr} ${controller.rides[index].startTime}")
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
                  TicketText.timeText(controller.rides[index].source),
                  TicketText.ttText(controller.rides[index].startTime),
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
              TicketText.durationText(controller.rides[index].startTime),
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
                  TicketText.timeText(controller.rides[index].destination),
                  TicketText.ttText(controller.rides[index].endTime),
                ],
              ),
            ],
          ),
          10.0.kH,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(ride.status == "Pending" ? "waiting".tr : "Accepted".tr),
            ],
          ),
        ],
      ),
    );
  }
}
