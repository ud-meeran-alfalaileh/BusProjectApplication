import 'package:drive_app/src/config/sizes/size_box_extension.dart';
import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/core/utils/loading_page.dart';
import 'package:drive_app/src/feature/rides/controller/user_rides_controller..dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeatLocationScreen extends StatefulWidget {
  const SeatLocationScreen({super.key, required this.rideId});
  final int rideId;

  @override
  State<SeatLocationScreen> createState() => _SeatLocationScreenState();
}

class _SeatLocationScreenState extends State<SeatLocationScreen> {
  final controller = Get.put(UserRidesController());

  final Map<String, Color> containerColors = {};
  final List<String> selectedSeats = [];
  final List<String> bookedSeats = ['2b', '3c', '4a']; // Mock API response
  final int totalContainers = 24;
  RxBool isLoadingStatus = false.obs;

  List<String> generateIds(int count) {
    List<String> ids = [];
    int cols = 4;

    for (int i = 0; i < count; i++) {
      int row = i ~/ cols + 1;
      String letter = String.fromCharCode(97 + (i % cols));
      ids.add('$row$letter');
    }
    return ids;
  }

  @override
  void initState() {
    super.initState();
    for (String seat in bookedSeats) {
      containerColors[seat] = AppTheme.lightAppColors.thirdTextcolor;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> ids = generateIds(totalContainers);

    return Scaffold(
        backgroundColor: AppTheme.lightAppColors.background,
        appBar: AppBar(
          backgroundColor: AppTheme.lightAppColors.primary,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppTheme.lightAppColors.background,
            ),
          ),
          actions: [
            TextButton(
              onPressed: selectedSeats.isNotEmpty
                  ? () {
                      isLoadingStatus.value = true;
                      controller.userAddBooking(
                        widget.rideId,
                        "",
                      );
                    }
                  : null,
              child: Text(
                "Next".tr,
                style: TextStyle(color: AppTheme.lightAppColors.background),
              ),
            ),
          ],
        ),
        body: Obx(
          () => isLoadingStatus.value
              ? loadingPage(context)
              : SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        width: context.screenWidth,
                        height: context.screenHeight * .2,
                        color: AppTheme.lightAppColors.primary,
                      ),
                      Column(
                        children: [
                          Center(
                            child: Container(
                              width: context.screenWidth * .9,
                              decoration: BoxDecoration(
                                  color: AppTheme.lightAppColors.background,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _booktitle(
                                            AppTheme
                                                .lightAppColors.thirdTextcolor,
                                            'Booked'.tr),
                                        _booktitle(
                                            AppTheme.lightAppColors.bordercolor,
                                            'Available'.tr),
                                        _booktitle(
                                            AppTheme
                                                .lightAppColors.secondaryColor,
                                            'Your Seat'.tr),
                                      ],
                                    ),
                                  ),
                                  25.0.kH,
                                  for (int i = 0; i < ids.length; i += 4)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        for (int j = 0; j < 2; j++)
                                          buildSeat(ids[i + j]),
                                        Spacer(),
                                        for (int j = 2; j < 4; j++)
                                          buildSeat(ids[i + j]),
                                      ],
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      selectedSeats.isNotEmpty
                                          ? '${'Selected Seat'.tr}: ${selectedSeats.first}'
                                          : 'No seat selected'.tr,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
        ));
  }

  Row _booktitle(color, title) {
    return Row(
      children: [
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7), color: color),
        ),
        10.0.kW,
        Text(
          title,
          style: TextStyle(
              color: Color(0xffA0A0A0),
              fontWeight: FontWeight.w600,
              fontSize: 13),
        )
      ],
    );
  }

  Widget buildSeat(String id) {
    bool isBooked = bookedSeats.contains(id);
    return GestureDetector(
      onTap: isBooked
          ? null
          : () {
              setState(() {
                if (selectedSeats.contains(id)) {
                  containerColors[id] = Colors.grey[300]!;
                  selectedSeats.clear();
                } else {
                  selectedSeats.clear();
                  containerColors.clear();
                  containerColors.addAll({
                    for (var seat in bookedSeats)
                      seat: AppTheme.lightAppColors.thirdTextcolor
                  });
                  containerColors[id] = AppTheme.lightAppColors.primary;
                  selectedSeats.add(id);
                }
              });
            },
      child: Container(
        margin: EdgeInsets.all(8),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: containerColors[id] ?? Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          id,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
