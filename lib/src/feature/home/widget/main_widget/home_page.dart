import 'dart:developer' as dd;
import 'dart:math';

import 'package:drive_app/src/config/sizes/size_box_extension.dart';
import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/core/utils/app_button.dart';
import 'package:drive_app/src/feature/location/controller/location_controller.dart';
import 'package:drive_app/src/feature/location/view/location_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocationController controller = Get.put(LocationController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: SafeArea(
        child: SizedBox(
          width: context.screenWidth,
          height: context.screenHeight,
          child: Stack(
            children: [
              Container(
                width: context.screenWidth,
                height: context.screenHeight * .3,
                color: AppTheme.lightAppColors.primary,
                child: Image.asset(
                  'assets/image/logo (2).png',
                  width: context.screenWidth * .3,
                ),
              ),
              Positioned(
                top: context.screenHeight * .2,
                left: 30,
                right: 30,
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: context.screenWidth * .7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppTheme.lightAppColors.secondaryColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      20.0.kH,
                      SizedBox(
                        width: context.screenWidth,
                        height: context.screenHeight * .14,
                        child: _buildForm(controller),
                      ),
                      20.0.kH,
                      Row(
                        children: [
                          _buildDatContainer("Today"),
                          10.0.kW,
                          _buildDatContainer("Tomorrow"),
                          10.0.kW,
                          _buildDatContainer("Other")
                        ],
                      ),
                      20.0.kH,
                      appButton(
                          onTap: () {
                            controller.end.value == null ||
                                    controller.start.value == null
                                ? {
                                    Get.to(MapScreen(
                                        controller: controller, type: "null"))
                                  }
                                : {
                                    Get.to(MapScreen(
                                        controller: controller,
                                        type: "notNull"))
                                  };
                          },
                          title: "Find Buses",
                          width: 200,
                          color: AppTheme.lightAppColors.primary)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildDatContainer(title) {
    return GestureDetector(
      onTap: () {
        title == "Other" ? showDatePickerDialog(context, controller) : null;
        controller.title.value = title;
        dd.log(controller.title.value);
      },
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
              color: controller.title != title
                  ? Colors.transparent
                  : AppTheme.lightAppColors.primary,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: controller.title == title
                      ? Colors.transparent
                      : AppTheme.lightAppColors.background)),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Row(
            children: [
              title == "Other"
                  ? Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Icon(
                        Icons.calendar_month,
                        size: 20,
                        color: AppTheme.lightAppColors.background,
                      ),
                    )
                  : SizedBox.shrink(),
              Text(
                title,
                style: TextStyle(
                    fontSize: 17,
                    color: AppTheme.lightAppColors.background,
                    fontFamily: "Kanti"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack _buildForm(LocationController controller) {
    return Stack(
      children: [
        Column(
          children: [
            buildSearchField(
              controller: controller,
              hint: 'Start Location',
              testContrller: controller.startLocationController,
              onSelect: (Prediction prediction) {
                controller.polylines.clear(); // Clear the route
                controller.routeCoords.clear(); // Clear the route coordinates
                controller.start(null); // Clear the start point

                controller.cameraMove(
                  double.parse(prediction.lat ?? '0.0'),
                  double.parse(prediction.lng ?? '0.0'),
                  'start',
                  'Start Location',
                );
                controller.start(LatLng(
                  double.parse(prediction.lat ?? '0.0'),
                  double.parse(prediction.lng ?? '0.0'),
                ));
              },
            ),
            Spacer(),
            buildSearchField(
              controller: controller,
              hint: 'End Location',
              testContrller: controller.endLocationController,
              onSelect: (Prediction prediction) {
                controller.polylines.clear(); // Clear the route
                controller.routeCoords.clear(); // Clear the route coordinates
                controller.end(null); // Clear the end point

                controller.cameraMove(
                  double.parse(prediction.lat ?? '0.0'),
                  double.parse(prediction.lng ?? '0.0'),
                  'end',
                  'End Location',
                );

                controller.end(LatLng(
                  double.parse(prediction.lat ?? '0.0'),
                  double.parse(prediction.lng ?? '0.0'),
                ));
              },
            ),
          ],
        ),
        _builsSwitchButton()
      ],
    );
  }

  void showDatePickerDialog(
      BuildContext contex, LocationController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 300,
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: CupertinoDatePicker(
                    itemExtent: 30,
                    mode: CupertinoDatePickerMode.dateAndTime,
                    onDateTimeChanged: (DateTime value) {
                      dd.log(value.toString());
                      controller.selectedDate.value = value;
                    },
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text("Close"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Align _builsSwitchButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => CircleAvatar(
            backgroundColor: AppTheme.lightAppColors.primary,
            child: Transform.rotate(
              angle: controller.isPickupLocation.value ? pi / 2.0 : pi / -2.0,
              child: IconButton(
                  color: AppTheme.lightAppColors.background,
                  onPressed: () {
                    String temp = controller.startLocationController.text;
                    controller.startLocationController.text =
                        controller.endLocationController.text;
                    controller.endLocationController.text = temp;

                    controller.isPickupLocation.value =
                        !controller.isPickupLocation.value;
                  },
                  icon: Icon(Icons.switch_right_sharp)),
            ),
          ),
        ),
      ),
    );
  }
}
