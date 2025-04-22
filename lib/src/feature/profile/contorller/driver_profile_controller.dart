import 'dart:convert';
import 'dart:developer';

import 'package:drive_app/src/core/api/api_services.dart';
import 'package:drive_app/src/core/api/end_points.dart';
import 'package:drive_app/src/core/api/injection_container.dart';
import 'package:drive_app/src/core/api/status_code.dart';
import 'package:drive_app/src/core/user.dart';
import 'package:drive_app/src/feature/profile/model/admin_profile_model.dart';
import 'package:drive_app/src/feature/rides/model/rides_model.dart';
import 'package:get/get.dart';

class DriverProfileController extends GetxController {
  RxBool isLoading = false.obs;
  final DioConsumer dioConsumer = sl<DioConsumer>();
  Rx<UserProfileModel?> driverProfile = Rx<UserProfileModel?>(null);
  User user = User();
  RxList<RidesModel> allRides = <RidesModel>[].obs;
  RxInt accptedDriverRides = 0.obs;
  RxInt startedRides = 0.obs;
  RxInt completedRides = 0.obs;
  RxInt rejectedRides = 0.obs;

  @override
  Future<void> onInit() async {
    getDriverProfile();
    super.onInit();
  }

  Future<void> getDriverProfile() async {
    isLoading.value = true;

    await user.loadId();

    try {
      final response =
          await dioConsumer.get("${EndPoints.driver}${user.driverID}");
      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.data);
        driverProfile.value = UserProfileModel.fromJson(responseData);
        await getAllRides();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllRides() async {
    try {
      await user.loadId();
      final response = await dioConsumer
          .get("${EndPoints.driverRidesW}${user.driverID.value}/WithDriver");

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

        rejectedRides.value =
            allRides.where((ride) => ride.status == "Rejected").toList().length;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
