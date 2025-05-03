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
import 'package:http/io_client.dart';

class RidesController extends GetxController {
  HttpClient getHttpClient() {
    final client = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    return client;
  }

  final DioConsumer dioConsumer = sl<DioConsumer>();

  RxBool isLoading = false.obs;
  //admin
  RxList<RidesModel> rides = <RidesModel>[].obs;

  //driver
  Rx<UserProfileModel?> driver = Rx<UserProfileModel?>(null);
  RxList<RidesModel> driverRides = <RidesModel>[].obs;

  User user = User();
  @override
  Future<void> onInit() async {
    // getAllRides();
    super.onInit();
  }

  //admin
  Future<void> getAllRides() async {
    try {
      isLoading.value = true;
      final response = await dioConsumer.get(EndPoints.allRides);

      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.data);
        rides.value =
            RidesModel.fromJsonList(responseData); // Assign rides first

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

  Future<void> changeStatus(id, isLoadingStatus, index, status) async {
    try {
      isLoadingStatus.value = true;

      var body = jsonEncode("$status"); // <-- This should probably be JSON

      final ioClient = IOClient(getHttpClient());
      final response = await ioClient.put(
        Uri.parse("${EndPoints.rides}$id/UpdateRideStatus"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.body);
        log(responseData.toString());
      } else {
        isLoadingStatus.value = false;
      }

      driverRides[index].status = status;
      driverRides.refresh();
    } catch (e) {
      log(e.toString());
      isLoadingStatus.value = false;
    } finally {
      isLoadingStatus.value = false;
    }
  }

  //driver
  Future<void> getRideForDrive() async {
    await user.loadId();
    try {
      isLoading.value = true;
      log("dkdkdk");
      final response = await dioConsumer
          .get("${EndPoints.driverRidesW}${user.driverID.value}/WithDriver");
      log(response.data + "dkdkdk");
      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.data);
        driverRides.value =
            RidesModel.fromJsonList(responseData); // Assign rides first.value =
        // driverRides.value = ride
        //     .where((ride) => ride.ride.status.toLowerCase() == "pending")
        //     .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false; // Set to false instead of true
    }
  }
}
