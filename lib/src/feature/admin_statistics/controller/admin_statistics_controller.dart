import 'dart:convert';
import 'dart:developer';

import 'package:drive_app/src/core/api/api_services.dart';
import 'package:drive_app/src/core/api/end_points.dart';
import 'package:drive_app/src/core/api/injection_container.dart';
import 'package:drive_app/src/core/api/status_code.dart';
import 'package:drive_app/src/core/user.dart';
import 'package:drive_app/src/feature/rides/model/rides_model.dart';
import 'package:get/get.dart';

class AdminStatisticsController extends GetxController {
  RxBool isLoading = false.obs;
  final DioConsumer dioConsumer = sl<DioConsumer>();
  User user = User();
  RxList<RidesModel> allRides = <RidesModel>[].obs;
  RxList<RidesModel> mostBooked = <RidesModel>[].obs;
  RxInt accptedDriverRides = 0.obs;
  RxInt startedRides = 0.obs;
  RxInt completedRides = 0.obs;
  RxInt elseRides = 0.obs;
  RxInt rejectedRides = 0.obs;

  @override
  Future<void> onInit() async {
    await getAllRides();
    await mostBookedRides();
    super.onInit();
  }

  Future<void> getAllRides() async {
    try {
      await user.loadId();
      final response = await dioConsumer.get(EndPoints.allRides);

      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.data);
        allRides.value =
            RidesModel.fromJsonList(responseData); // Assign rides first
        accptedDriverRides.value =
            allRides.where((ride) => ride.status == "Accpted").toList().length;
        startedRides.value = allRides
            .where((ride) => ride.status == "In Progress")
            .toList()
            .length;
        completedRides.value = allRides
            .where((ride) => ride.status == "Completed")
            .toList()
            .length;
        elseRides.value =
            allRides.where((ride) => ride.status == "Pending").toList().length;

        rejectedRides.value =
            allRides.where((ride) => ride.status == "Rejected").toList().length;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> mostBookedRides() async {
    try {
      await user.loadId();
      final response = await dioConsumer
          .get("https://166.1.227.210:7014/api/MostBookedRides");

      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.data);
        mostBooked.value =
            RidesModel.fromJsonList(responseData); // Assign rides first
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
