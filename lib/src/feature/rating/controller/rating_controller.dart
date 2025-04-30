import 'dart:convert';
import 'dart:developer';

import 'package:drive_app/src/core/api/api_services.dart';
import 'package:drive_app/src/core/api/end_points.dart';
import 'package:drive_app/src/core/api/injection_container.dart';
import 'package:drive_app/src/core/api/status_code.dart';
import 'package:drive_app/src/feature/rating/model/rating_model.dart';
import 'package:drive_app/src/feature/rides/model/book_model.dart';
import 'package:drive_app/src/feature/rides/model/rides_model.dart';
import 'package:get/get.dart';

class RatingController extends GetxController {
  final DioConsumer dioConsumer = sl<DioConsumer>();
  RxBool isloading = false.obs;
  RxList<BookingModel> allBookedRide = <BookingModel>[].obs;
  RxList<RatingModel> ratingList = <RatingModel>[].obs;
  RxList<RidesModel> rideList = <RidesModel>[].obs;

  Future<void> getAllRating() async {
    try {
      final response = await dioConsumer.get(EndPoints.allReview);
      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.data);
        ratingList.value = RatingModel.fromJsonList(responseData);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getAllRides() async {
    try {
      final response =
          await dioConsumer.get("https://166.1.227.210:7014/api/Booking/all");
      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.data);
        rideList.value = RidesModel.fromJsonListfromJsonBooking(responseData);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getUserBooking() async {
    allBookedRide.clear();
    isloading.value = true;

    try {
      final response = await dioConsumer.get(
          "https://166.1.227.210:7014/api/Booking/7/booking/Details");
      log(response.data);
      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.data);
        allBookedRide.value = BookingModel.fromJsonList(responseData);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isloading.value = false;
    }
  }
}
