import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:drive_app/src/core/api/api_services.dart';
import 'package:drive_app/src/core/api/end_points.dart';
import 'package:drive_app/src/core/api/injection_container.dart';
import 'package:drive_app/src/core/api/status_code.dart';
import 'package:drive_app/src/core/user.dart';
import 'package:drive_app/src/feature/profile/model/admin_profile_model.dart';
import 'package:drive_app/src/feature/rides/model/rides_model.dart';
import 'package:get/get.dart';

class DriverRidesController extends GetxController {
  HttpClient getHttpClient() {
    final client = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    return client;
  }

  RxBool isLoading = false.obs;
  Rx<UserProfileModel?> driver = Rx<UserProfileModel?>(null);
  RxList<RidesModel> accptedDriverRides = <RidesModel>[].obs;
  RxList<RidesModel> todayRides = <RidesModel>[].obs;
  final DioConsumer dioConsumer = sl<DioConsumer>();
  User user = User();
  @override
  Future<void> onInit() async {
    await getRideForDrive();
    await getRideForToday();
    super.onInit();
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

  Future<void> changeStatus(id, isLoadingStatus, index, status) async {
    // try {
    //   isLoadingStatus.value = true;

    //   var body = jsonEncode("$status"); // <-- This should probably be JSON

    //   final ioClient = IOClient(getHttpClient());
    //   final response = await ioClient.put(
    //     Uri.parse("${EndPoints.rides}$id/UpdateRideStatus"),
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'Accept': 'application/json',
    //     },
    //     body: body,
    //   );

    //   if (response.statusCode == StatusCode.ok) {
    //     final responseData = jsonDecode(response.body);
    //     log(responseData.toString());
    //   } else {
    //     isLoadingStatus.value = false;
    //   }

    //   accptedDriverRides[index].status = status;
    //   accptedDriverRides.refresh();
    // } catch (e) {
    //   log(e.toString());
    //   isLoadingStatus.value = false;
    // } finally {
    //   isLoadingStatus.value = false;
    // }
  }

  Future<void> getRideForDrive() async {
    await user.loadId();
    try {
      isLoading.value = true;
      final response = await dioConsumer
          .get("${EndPoints.driverRidesW}${user.driverID.value}/WithDriver");
      log(response.data);
      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.data);
        final rides =
            RidesModel.fromJsonList(responseData); // Assign rides first.value =
        accptedDriverRides.value = rides
            .where((ride) =>
                ride.status == "Accpted" ||
                ride.status == "Completed" ||
                ride.status == "Started" ||
                ride.status == "In Progress")
            .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false; // Set to false instead of true
    }
  }

  Future<void> getRideForToday() async {
    await user.loadId();
    try {
      isLoading.value = true;

      final response = await dioConsumer
          .get("${EndPoints.driverRidesW}${user.driverID.value}/WithDriver");
      log(response.data);

      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.data);
        final rides = RidesModel.fromJsonList(responseData);

        final today = DateTime.now();

        todayRides.value = rides.where((ride) {
          final rideDate = DateTime.parse(ride.startDate); // using your format
          final isToday = rideDate.year == today.year &&
              rideDate.month == today.month &&
              rideDate.day == today.day;

          return isToday &&
              (ride.status == "Accpted" ||
                  ride.status == "Started" ||
                  ride.status == "In Progress");
        }).toList();

        // driver.value = await getDriver(user.driverID.value);

        // for (var i = 0; i < todayRides.length; i++) {
        //   todayRides[i] = todayRides[i].copyWith(driver: driver.value);
        // }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
