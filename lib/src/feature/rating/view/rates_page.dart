import 'package:drive_app/src/config/sizes/size_box_extension.dart';
import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/feature/rating/controller/rating_controller.dart';
import 'package:drive_app/src/feature/rides/model/book_model.dart';
import 'package:drive_app/src/feature/rides/model/rides_model.dart';
import 'package:drive_app/src/feature/rides/view/riders_text.dart';
import 'package:drive_app/src/feature/tickets/view/widget/ticket_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class RatesPage extends StatelessWidget {
  const RatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RatingController())..getUserBooking();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("All Rating".tr),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  itemCount: controller.allBookedRide.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return 20.0.kH;
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final ride = controller.allBookedRide[index].ride
                        .firstWhere((ride) =>
                            ride.id == controller.allBookedRide[index].rideId);
                    return _buildTripContainer(ride, index,
                        controller.allBookedRide[index], context, "fromList");
                  },
                ),
                40.0.kH,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildTripContainer(RidesModel ride, int index, BookingModel book,
      BuildContext context, fromList) {
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
                  RidersText.mainText(book.busDriverName ?? "Loading..."),
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
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: book.ratings.length,
            separatorBuilder: (BuildContext context, int index) {
              return 10.0.kH;
            },
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.lightAppColors.background,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/image/user.png'),
                        ),
                        Center(
                          child: RatingBar.builder(
                            initialRating: book.ratings[index].ratingValue,
                            minRating: 1,
                            updateOnDrag: false,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(
                                horizontal: context.screenWidth * .002),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: AppTheme.lightAppColors.secondaryColor,
                            ),
                            onRatingUpdate:
                                (_) {}, // Still required, but will not trigger
                            ignoreGestures: true, // ✅ Makes it non-interactive
                          ),
                        ),
                      ],
                    ),
                    5.0.kH,
                    Text(
                      book.ratings[index].note,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
