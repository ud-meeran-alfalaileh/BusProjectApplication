import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:drive_app/src/core/api/api_services.dart';
import 'package:drive_app/src/core/api/end_points.dart';
import 'package:drive_app/src/core/api/injection_container.dart';
import 'package:drive_app/src/core/api/status_code.dart';
import 'package:drive_app/src/core/user.dart';
import 'package:drive_app/src/feature/nav_bar/view/main/navbar_page.dart';
import 'package:drive_app/src/feature/profile/model/admin_profile_model.dart';
import 'package:drive_app/src/feature/rides/model/book_model.dart';
import 'package:drive_app/src/feature/rides/model/rides_model.dart';
import 'package:get/get.dart';

class UserRidesController extends GetxController {
  HttpClient getHttpClient() {
    final client = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    return client;
  }

  final DioConsumer dioConsumer = sl<DioConsumer>();

  RxBool isLoading = false.obs;
  RxBool isLoadingTickert = false.obs;
  //studen
  RxDouble userRating = 0.0.obs;
  RxList<BookingModel> allBookedRide = <BookingModel>[].obs;
  RxList<BookModel> booking = <BookModel>[].obs;
  RxList<RidesModel> allRides = <RidesModel>[].obs;
  RxList<RidesModel> userRides = <RidesModel>[].obs;
  RxList<RidesModel> otherRides = <RidesModel>[].obs;
  User user = User();
  @override
  Future<void> onInit() async {
    // getUserBooking();
    super.onInit();
  }

  Future<UserProfileModel?> getDriver(id) async {
    try {
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

      return null;
    }
  }

  // Future<void> changeStatus(id, isLoadingStatus, index, status) async {
  //   try {
  //     isLoadingStatus.value = true;
  //     var body = jsonEncode("$status"); // <-- This should probably be JSON
  //     final ioClient = IOClient(getHttpClient());
  //     final response = await ioClient.put(
  //       Uri.parse("${EndPoints.rides}$id/UpdateRideStatus"),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //       },
  //       body: body,
  //     );
  //     if (response.statusCode == StatusCode.ok) {
  //       final responseData = jsonDecode(response.body);
  //       log(responseData.toString());
  //     } else {
  //       isLoadingStatus.value = false;
  //     }
  //     driverRides[index].status = status;
  //     driverRides.refresh();
  //   } catch (e) {
  //     log(e.toString());
  //     isLoadingStatus.value = false;
  //   } finally {
  //     isLoadingStatus.value = false;
  //   }
  // }

  Future<List<RidesModel>> getAllRidesForUser(
      {String? from, String? toLocation, DateTime? date}) async {
    try {
      await user.loadGender();
      String genderEn = '';
      String genderAr = '';
      isLoading.value = true;
      if (user.userGender.value == "Male" || user.userGender.value == "ذكر") {
        genderEn = "Male";
        genderAr = "ذكر";
      } else {
        genderEn = "Female";
        genderAr = "أنثى";
      }

      final response = await dioConsumer.get(EndPoints.allRides);
      log(response.data.toString());
      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.data);
        allRides.value = RidesModel.fromJsonList(responseData);

        userRides.value = allRides.where((ride) {
          final matchesFrom = from!.isEmpty || ride.source == from;
          final matchesTo =
              toLocation!.isEmpty || ride.destination == toLocation;
          final matchStatus = ride.status.toLowerCase() == "accpted";

          return matchesFrom && matchesTo && matchStatus;
        }).toList();

        otherRides.value = allRides
            .where((ride) =>
                ride.status.toLowerCase() == "Accpted" &&
                (ride.gender == genderAr || ride.gender == genderEn) &&
                !userRides.any((uRide) => uRide.rideId == ride.rideId))
            .toList();
        return allRides;
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
    return [];
  }

  Future<List<RidesModel>> getAllRides(
      {String? from, String? toLocation, DateTime? date}) async {
    try {
      await user.loadGender();

      final response = await dioConsumer.get(EndPoints.allRides);

      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.data);
        allRides.value = RidesModel.fromJsonList(responseData);

        // for (var i = 0; i < allRides.length; i++) {
        //   final driver = await getDriver(allRides[i].busDriverId);
        //   if (driver != null) {
        //     allRides[i] = allRides[i].copyWith(driver: driver);
        //   }
        // }

        return allRides;
      }
    } catch (e) {
      log(e.toString());
    } finally {}
    return [];
  }

  Future<void> userAddBooking(
    int rideId,
    String fromList,
  ) async {
    try {
      await user.loadId();
      var body = ({
        "rideId": rideId,
        "studentId": user.userId.value,
        "status": "Booked"
      });

      log(body.toString());

      final response = await dioConsumer.post(EndPoints.addBooking, body: body);
      log(response.data);
      if (response.statusCode == StatusCode.ok) {}
      Get.off(NavBarPage());
    } catch (e) {
      log(e.toString());
    } finally {}
  }

  Future<void> getUserBooking() async {
    allBookedRide.clear();
    await user.loadId();
    isLoadingTickert.value = true;
    final allRides = await getAllRides();

    try {
      final response = await dioConsumer.get(
          "https://166.1.227.210:7014/api/Booking/${user.userId.value}/booking/Details");
      log(response.data);
      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.data);
        allBookedRide.value = BookingModel.fromJsonList(responseData);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoadingTickert.value = false;
    }
  }

  Future<void> deleteBooking(RxBool isLoading, int id) async {
    isLoading.value = true;

    try {
      final response = await dioConsumer.delete("${EndPoints.booking}$id");
      allBookedRide.removeWhere((book) => book.bookingId == id);
      // allBookedRide.refresh();
      log(response.toString());
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
