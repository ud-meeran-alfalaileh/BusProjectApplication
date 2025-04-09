import 'package:drive_app/src/config/sizes/size_box_extension.dart';
import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/core/utils/app_button.dart';
import 'package:drive_app/src/feature/rides/controller/add_rides_controller.dart';
import 'package:drive_app/src/feature/login/model/login_form_model.dart';
import 'package:drive_app/src/feature/login/view/widgte/collection/auth_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AddRidesPage extends StatefulWidget {
  const AddRidesPage({super.key});

  @override
  State<AddRidesPage> createState() => _AddRidesPageState();
}

class _AddRidesPageState extends State<AddRidesPage> {
  final controller = Get.put(AddRidesController())..getAllDriver();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildHeader(context, "Add Rides".tr),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildLocatinoSelction('From'),
                    20.0.kH,
                    // Text(controller.selectedEndLocation.value!),
                    _buildLocatinoSelction('To'),
                    SizedBox(height: 20),
                    Obx(() => controller.selectedStartLocation.value == null &&
                            controller.selectedEndLocation.value == null
                        ? SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // SizedBox(
                              //   width: context.screenWidth * .3,
                              //   child: _buildSelectTime(context,
                              //       controller.startSelected, "Start Time".tr),
                              // ),
                              // SizedBox(
                              //   width: context.screenWidth * .3,
                              //   child: _buildSelectTime(context,
                              //       controller.endSelected, "End Time".tr),
                              // ),
                              SizedBox(
                                  width: context.screenWidth * .4,
                                  child: _buildTimeSelection('From')),
                              SizedBox(
                                  width: context.screenWidth * .4,
                                  child: _buildTimeSelection('To')),
                            ],
                          )),
                    20.0.kH,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSelectDate(
                            context,
                            controller.startDateController,
                            controller.startDate.value,
                            "Start Date".tr),
                        _buildSelectDate(context, controller.endDateController,
                            controller.endDate.value, "End Date".tr),
                      ],
                    ),
                    20.0.kH,
                    _buildSelectGender(),
                    20.0.kH,
                    _buildDriverSelction(),

                    20.0.kH,

                    appButton(
                        onTap: () {
                          controller.addRides();
                        },
                        title: "Add Rides".tr,
                        width: context.screenWidth * .4)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _buildDriverSelction() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Driver'.tr,
          style: TextStyle(
              color: AppTheme.lightAppColors.black,
              fontFamily: "Kanti",
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        5.0.kH,
        Obx(() {
          if (controller.isLoadingDriver.value) {
            return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: context.screenWidth,
                  height: context.screenHeight * .06,
                  decoration: BoxDecoration(
                      color: AppTheme.lightAppColors.containercolor,
                      borderRadius: BorderRadius.circular(30)),
                ));
          }
          return DropdownButtonFormField<int>(
            value: controller.selectedDriver.value == 0
                ? null
                : controller.selectedDriver.value,
            items: controller.drivers.map((driver) {
              return DropdownMenuItem<int>(
                value: driver.id,
                child: Text(driver.name),
              );
            }).toList(),
            onChanged: (int? newValue) {
              controller.selectedDriver.value = newValue!;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              filled: true,
              fillColor:
                  AppTheme.lightAppColors.background.withValues(alpha: .9),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.lightAppColors.mainTextcolor
                      .withValues(alpha: .1),
                ),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.lightAppColors.mainTextcolor
                      .withValues(alpha: .1),
                ),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              hintText: "Select Driver".tr,
              hintStyle: TextStyle(
                fontFamily: "kanti",
                fontWeight: FontWeight.w200,
                color: Colors.grey,
              ),
            ),
          );
        }),
      ],
    );
  }

  Column _buildSelectGender() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        5.0.kH,
        Text(
          'Gender'.tr,
          style: TextStyle(
              color: AppTheme.lightAppColors.black,
              fontFamily: "Kanti",
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        Obx(
          () => DropdownButtonFormField<String>(
            value: controller.selectedGender.value,
            items: [
              "Male".tr,
              "Female".tr,
            ].map((String gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Text(
                  gender,
                  style: TextStyle(
                    fontFamily: "kanti",
                    fontWeight: FontWeight.w200,
                    color: AppTheme.lightAppColors.mainTextcolor,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                controller.setGender(newValue);
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              filled: true,
              fillColor:
                  AppTheme.lightAppColors.background.withValues(alpha: .9),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.lightAppColors.mainTextcolor
                      .withValues(alpha: .1),
                ),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.lightAppColors.mainTextcolor
                      .withValues(alpha: .1),
                ),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              hintText: "Select Gender".tr,
              hintStyle: TextStyle(
                fontFamily: "kanti",
                fontWeight: FontWeight.w200,
                color: AppTheme.lightAppColors.subTextcolor,
              ),
            ),
          ),
        )
      ],
    );
  }

  Column _buildLocatinoSelction(String type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        5.0.kH,
        Text(
          type == "From" ? 'From Location'.tr : 'To Location'.tr,
          style: TextStyle(
              color: AppTheme.lightAppColors.black,
              fontFamily: "Kanti",
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        Obx(
          () {
            // Get the available options for "To" dropdown
            List<String> filteredLocations =
                controller.locations.where((location) {
              if (type == "To") {
                return location != controller.selectedStartLocation.value;
              }
              return true;
            }).toList();

            return DropdownButtonFormField<String>(
              value: type == "From"
                  ? controller.selectedStartLocation.value
                  : controller.selectedEndLocation.value,
              items: filteredLocations.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(
                    location,
                    style: TextStyle(
                      fontFamily: "Kanti",
                      fontWeight: FontWeight.w200,
                      color: AppTheme.lightAppColors.mainTextcolor,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  if (type == "From") {
                    controller.selectedStartLocation.value = newValue;
                    controller.selectedEndLocation.value =
                        null; // Reset "To" selection
                  } else {
                    controller.selectedEndLocation.value = newValue;
                  }
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                filled: true,
                fillColor:
                    AppTheme.lightAppColors.background.withValues(alpha: .9),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppTheme.lightAppColors.mainTextcolor
                        .withValues(alpha: .1),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppTheme.lightAppColors.mainTextcolor
                        .withValues(alpha: .1),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                hintText:
                    type == "From" ? 'From Location'.tr : 'To Location'.tr,
                hintStyle: TextStyle(
                  fontFamily: "Kanti",
                  fontWeight: FontWeight.w200,
                  color: AppTheme.lightAppColors.subTextcolor,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Column _buildTimeSelection(String type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        5.0.kH,
        Text(
          type == "From" ? "Start Time".tr : "End Time".tr,
          style: TextStyle(
              color: AppTheme.lightAppColors.black,
              fontFamily: "Kanti",
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        Obx(
          () {
            // Ensure we only show valid times for "End Time"
            List<String> filteredTimes = controller.busSchedules.where((time) {
              if (type == "To" && controller.selectedStartTime.value != null) {
                return time.compareTo(controller.selectedStartTime.value!) > 0;
              }
              return true;
            }).toList();

            // Reset "End Time" if the selected one is no longer valid
            if (type == "To" &&
                controller.selectedEndTime.value != null &&
                !filteredTimes.contains(controller.selectedEndTime.value)) {
              controller.selectedEndTime.value = ""; // Reset invalid selection
            }

            return DropdownButtonFormField<String>(
              value: type == "From"
                  ? (controller.selectedStartTime.value != null
                      ? null
                      : controller.selectedStartTime.value)
                  : (controller.selectedEndTime.value != null
                      ? null
                      : controller.selectedEndTime.value),
              items: filteredTimes.map((String time) {
                return DropdownMenuItem<String>(
                  value: time,
                  child: Text(
                    time,
                    style: TextStyle(
                      fontFamily: "Kanti",
                      fontWeight: FontWeight.w200,
                      color: AppTheme.lightAppColors.mainTextcolor,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  if (type == "From") {
                    controller.selectedStartTime.value = newValue;
                    controller.selectedEndTime.value =
                        ""; // Reset "End Time" when "Start Time" changes
                  } else {
                    controller.selectedEndTime.value = newValue;
                  }
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                filled: true,
                fillColor:
                    AppTheme.lightAppColors.background.withValues(alpha: .9),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppTheme.lightAppColors.mainTextcolor
                        .withValues(alpha: .1),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppTheme.lightAppColors.mainTextcolor
                        .withValues(alpha: .1),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                hintText: type == "From" ? "Start Time".tr : "End Time".tr,
                hintStyle: TextStyle(
                  fontFamily: "Kanti",
                  fontWeight: FontWeight.w200,
                  color: AppTheme.lightAppColors.subTextcolor,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  SizedBox _buildSelectDate(BuildContext context,
      TextEditingController textContrller, DateTime date, title) {
    return SizedBox(
      width: context.screenWidth * .4,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: AppTheme.lightAppColors.black,
                    fontFamily: "Kanti",
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              5.0.kH,
              AuthForm(
                  textAlign: TextAlign.center,
                  formModel: FormModel(
                      controller: textContrller,
                      enableText: true,
                      hintText: title,
                      invisible: false,
                      validator: (value) => controller.validField(value),
                      type: TextInputType.text,
                      inputFormat: [],
                      onTap: null)),
            ],
          ),
          GestureDetector(
            onTap: () {
              controller.selectDate(context, date, textContrller);
            },
            child: Container(
              width: context.screenWidth,
              color: Colors.transparent,
              height: context.screenHeight * .08,
            ),
          )
        ],
      ),
    );
  }
}

Container buildHeader(BuildContext context, title) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    width: context.screenWidth,
    height: context.screenHeight * .1,
    decoration: BoxDecoration(
        color: AppTheme.lightAppColors.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
    child: Center(
      child: Stack(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: AppTheme.lightAppColors.background,
                  )),
            ],
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
                  color: AppTheme.lightAppColors.background,
                  fontFamily: "Kanti",
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    ),
  );
}
