import 'package:drive_app/src/config/sizes/size_box_extension.dart';
import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/core/utils/app_button.dart';
import 'package:drive_app/src/feature/rides/controller/user_rides_controller.dart';
import 'package:drive_app/src/feature/rides/model/rides_model.dart';
import 'package:drive_app/src/feature/rides/view/riders_text.dart';
import 'package:drive_app/src/feature/tickets/view/widget/ticket_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
      controller.allBookedRide.clear();
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
              () => controller.isLoadingTickert.value
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
                          itemCount: controller.allBookedRide.first.ride.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return 20.0.kH;
                          },
                          itemBuilder: (BuildContext context, int index) {
                            final ride =
                                controller.allBookedRide.first.ride[index];
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
              CircleAvatar(
                  radius: 26,
                  backgroundColor: AppTheme.lightAppColors.background,
                  backgroundImage: AssetImage('assets/image/logo (2).png')),
              10.0.kW,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RidersText.mainText(ride?.name ?? "Loading..."),
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
          if (ride.status == "Accpted")
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                appButton(
                    onTap: () {
                      controller.deleteBooking(
                        isLoadingStatus,
                        ride.rideId!,
                      );
                    },
                    title: "cancel".tr,
                    width: context.screenWidth * .3,
                    color: AppTheme.lightAppColors.thirdTextcolor),
              ],
            ),
          if (ride.status == "In Progress")
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                appButton(
                    onTap: () {},
                    title: "Started".tr,
                    width: context.screenWidth * .3,
                    color: Colors.green),
              ],
            ),
          if (ride.status == "Completed")
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                appButton(
                    onTap: () {
                      showDraggableBottomSheet(
                        context,
                        ride,
                        controller,
                      );
                    },
                    title: "Rate".tr,
                    width: context.screenWidth * .3,
                    color: AppTheme.lightAppColors.primary),
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

void showDraggableBottomSheet(
    BuildContext context, RidesModel book, UserRidesController controller) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.5, // Initial = 50% of screen
        minChildSize: 0.3, // Min drag down = 30%
        maxChildSize: 1.0, // Max drag up = full screen
        expand: false,
        builder: (context, scrollController) {
          return pendingReviewContainer(context, book, controller);
        },
      );
    },
  );
}

Container pendingReviewContainer(
    BuildContext context, RidesModel book, UserRidesController controller) {
  return Container(
    padding: const EdgeInsets.all(20),
    width: context.screenWidth * .84,
    decoration: BoxDecoration(
      color: AppTheme.lightAppColors.background,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Displaying the service name and details

        Center(
          child: RatingBar.builder(
            initialRating: 5,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding:
                EdgeInsets.symmetric(horizontal: context.screenWidth * .002),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: AppTheme.lightAppColors.secondaryColor,
            ),
            onRatingUpdate: (rating) {
              controller.userRating.value = rating;
            },
          ),
        ),
        const SizedBox(height: 20),

        Row(
          children: [
            Text(
              "Write a review message:".tr,
              style: const TextStyle(fontFamily: "Inter", fontSize: 16),
            ),
          ],
        ),

        // Submit Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: context.screenWidth * .25,
              child: appButton(
                  onTap: () {
                    controller.userRating.value = 0.0;
                  },
                  title: 'later'.tr,
                  width: 20),
            ),
            appButton(
              width: context.screenWidth * .25,
              onTap: () {
                // doctorController.postReview(
                //     review.reviewId,
                //     'Done',
                //     PostNotificationModel(
                //         title: "title",
                //         message: "message",
                //         imageURL: "imageURL",
                //         externalIds: "externalIds",
                //         route: ''),
                //     review.vendorId,
                //     review.bookingId);
              },
              title: 'Submit'.tr,
            ),
          ],
        ),
      ],
    ),
  );
}
