import 'dart:convert';
import 'dart:developer';

import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/core/api/api_services.dart';
import 'package:drive_app/src/core/api/end_points.dart';
import 'package:drive_app/src/core/api/injection_container.dart';
import 'package:drive_app/src/core/api/status_code.dart';
import 'package:drive_app/src/core/user.dart';
import 'package:drive_app/src/feature/profile/model/admin_profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddRidesController extends GetxController {
  User user = User();
  RxBool isLoadingDriver = false.obs;
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final startLocationController = TextEditingController();
  final endLocationController = TextEditingController();
  final Rx<DateTime> startDate = DateTime.now().obs;
  final Rx<DateTime> endDate = DateTime.now().obs;
  RxList<UserProfileModel> drivers = <UserProfileModel>[].obs;
  RxInt selectedDriver = 0.obs;

  final DioConsumer dioConsumer = sl<DioConsumer>();
  DateFormat dateFormat =
      DateFormat('yyyy-MM-dd'); // For date format: yyyy-MM-dd
  DateFormat timeFormat = DateFormat('HH:mm:ss'); // For time format: HH:mm:ss
  var selectedGender = RxnString(); // Reactive gender selection
  var selectedStartLocation = RxnString(); // Reactive gender selection
  var selectedEndLocation = RxnString(); // Reactive gender selection
  var selectedStartTime = RxnString(); // Reactive gender selection
  var selectedEndTime = RxnString(); // Reactive gender selection

  validField(String? name) {
    if (name!.isEmpty) {
      return "Please fill the fields".tr;
    }
    return null;
  }

  void setGender(String gender) {
    selectedGender.value = gender;
  }

  List<String> locations = [
    "كلية التربية والآداب",
    "عمادة شؤون الطلاب",
    "كلية الصيدلة",
    "كلية الطب",
    "المستشفى",
    "إدارة الأعمال",
    "المكتبة",
    "الصالة الرياضية",
    "سكن طلاب المنح",
    "كلية إدارة الأعمال",
    "كلية التربية",
    "كلية الشريعة والقانون",
  ];
  RxString selectedTime = ''.obs;

  List<String> busSchedules = [
    "07:55:00",
    "08:05:00",
    "08:15:00",
    "08:25:00",
    "08:35:00",
    "08:45:00"
  ];

  Future<void> addRides() async {
    await user.loadId();
    log(selectedStartTime.toString());
    // DateTime startTime =
    //     DateFormat('HH:mm:ss').parse('${selectedStartTime.value!}:00');
    // DateTime endTime = DateFormat('HH:mm:ss').parse(selectedEndTime.value!);
//source
//destination
//busNumber
    var body = jsonEncode({
      "startTime": selectedStartTime.value,
      "endTime": selectedEndTime.value,
      "startDate": dateFormat.format(startDate.value),
      "endDate": dateFormat.format(endDate.value),
      "source": selectedStartLocation.value,
      "destination": selectedEndLocation.value,
      "busDriverId": selectedDriver.value,
      "gender": selectedGender.value,
      "status": "Pending",
      "adminId": user.adminID.value,
      "busNumber": selectedDriver.value,
    });
    final response = await dioConsumer.post(EndPoints.postRide, body: body);
    log(response.data);
    log(response.statusCode.toString());
    if (response.statusCode == StatusCode.ok) {
      Get.back();
    }
  }

  Future<void> getAllDriver() async {
    try {
      isLoadingDriver.value = true;
      final response = await dioConsumer.get(EndPoints.allDriver);
      if (response.statusCode == StatusCode.ok) {
        final repsonseData = jsonDecode(response.data);
        drivers.value = UserProfileModel.fromJsonList(repsonseData);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoadingDriver.value = false;
    }
  }

  Future<void> selectTime(
    BuildContext context,
    TextEditingController text,
  ) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: context.screenHeight * .3,
          color: Colors.white,
          child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            initialTimerDuration: const Duration(hours: 0, minutes: 0),
            onTimerDurationChanged: (Duration newTime) {
              final hour = newTime.inHours;
              text.text = "$hour:00"; // Display only the hour with 00 minutes
            },
          ),
        );
      },
    );
  }

  Future<void> selectDate(BuildContext context, DateTime selectedDate,
      TextEditingController textController) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date, // Show only date
                  initialDateTime: selectedDate,
                  onDateTimeChanged: (DateTime newDate) {
                    textController.text =
                        DateFormat('yyyy-MM-dd').format(newDate);
                  },
                ),
              ),
              CupertinoButton(
                child: const Text("Done"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
