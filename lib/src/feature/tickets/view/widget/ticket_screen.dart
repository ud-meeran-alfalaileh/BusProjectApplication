import 'package:drive_app/src/config/sizes/size_box_extension.dart';
import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/core/utils/app_button.dart';
import 'package:drive_app/src/feature/rides/controller/user_rides_controller..dart';
import 'package:drive_app/src/feature/rides/model/rides_model.dart';
import 'package:drive_app/src/feature/rides/view/riders_text.dart';
import 'package:drive_app/src/feature/tickets/view/widget/ticket_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  final controller = Get.put(UserRidesController());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getUserBooking();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            20.0.kH,
            Obx(
              () => controller.isLoading.value
                  ? CircularProgressIndicator()
                  : controller.allBookedRide.isEmpty
                      ? Column(
                          children: [
                            200.0.kH,
                            Center(
                              child: RidersText.bigText(
                                  'You don’t have a ticket.'.tr),
                            ),
                            100.0.kH,
                          ],
                        )
                      : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          itemCount: controller.allBookedRide.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return 20.0.kH;
                          },
                          itemBuilder: (BuildContext context, int index) {
                            final ride = controller.allBookedRide[index];
                            return _buildTripContainer(
                                ride, index, context, controller, "fromList");
                          },
                        ),
            ),
            100.0.kH
          ],
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
              Text(ride.id.toString()),
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
                            onTap: () {
                              controller.deleteBooking(
                                isLoadingStatus,
                                ride.id,
                              );
                            },
                            title: "cancel".tr,
                            width: context.screenWidth * .3,
                            color: AppTheme.lightAppColors.thirdTextcolor),
                      ],
                    ),
        ],
      ),
    );
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40),
      width: context.screenWidth,
      height: context.screenHeight * .14,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
        color: AppTheme.lightAppColors.primary,
      ),
      child: Center(
        child: Text(
          "Tickets".tr,
          style: TextStyle(
              color: AppTheme.lightAppColors.background,
              fontSize: 25,
              fontFamily: "Kanti",
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
