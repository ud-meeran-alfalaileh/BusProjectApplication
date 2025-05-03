import 'dart:convert';
import 'dart:developer';

import 'package:drive_app/src/core/api/api_services.dart';
import 'package:drive_app/src/core/api/injection_container.dart';
import 'package:drive_app/src/core/api/status_code.dart';
import 'package:drive_app/src/feature/rating/model/rating_model.dart';
import 'package:drive_app/src/feature/rides/model/book_model.dart';
import 'package:drive_app/src/feature/rides/model/rides_model.dart';
import 'package:get/get.dart';

class RatingController extends GetxController {
  final DioConsumer dioConsumer = sl<DioConsumer>();
  RxBool isLoading = false.obs;
   RxList<RatingModel> ratingList = <RatingModel>[].obs;
 
  Future<void> getAllRating() async {
    isLoading.value = true;
    try {
      final response = await dioConsumer
          .get("https://166.1.227.210:7014/RattingswithRidesAll");
      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.data);
        ratingList.value = RatingModel.fromJsonList(responseData);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
 
}
