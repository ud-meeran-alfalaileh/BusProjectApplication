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

class RidesController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<RidesModel> rides = <RidesModel>[].obs;
  Rx<UserProfileModel?> driver = Rx<UserProfileModel?>(null);
  RxList<RidesModel> driverRides = <RidesModel>[].obs;
  final DioConsumer dioConsumer = sl<DioConsumer>();
  User user = User();
  @override
  Future<void> onInit() async {
    // getAllRides();
    super.onInit();
  }

  Future<void> getAllRides() async {
    try {
      isLoading.value = true;
      final response = await dioConsumer.get(EndPoints.allRides);

      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.data);
        rides.value =
            RidesModel.fromJsonList(responseData); // Assign rides first

        for (var i = 0; i < rides.length; i++) {
          final driver = await getDriver(rides[i].busDriverId);
          if (driver != null) {
            rides[i] = rides[i].copyWith(driver: driver); // Ensure immutability
          }
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false; // Set to false instead of true
    }
  }

  Future<UserProfileModel?> getDriver(id) async {
    try {
      isLoading.value = true;
      final response = await dioConsumer.get("${EndPoints.driver}$id");
      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.data);
        return UserProfileModel.fromJson(responseData);
      } else {
        isLoading.value = true;

        return null;
      }
    } catch (e) {
      log(e.toString());
      isLoading.value = true;

      return null;
    }
  }

  Future<void> getRideForDrive() async {
    await user.loadId();
    try {
      isLoading.value = true;
      final response = await dioConsumer
          .get("${EndPoints.driverRides}${user.driverID.value}/trips");
      log(response.data);
      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.data);
        driverRides.value =
            RidesModel.fromJsonList(responseData); // Assign rides first.value =

        driver.value = await getDriver(user.driverID.value);
        for (var i = 0; i < driverRides.length; i++) {
          driverRides[i] = driverRides[i]
              .copyWith(driver: driver.value); // Ensure immutability
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false; // Set to false instead of true
    }
  }
}
