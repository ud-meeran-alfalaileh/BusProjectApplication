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

class UserProfileController extends GetxController {
  RxBool isLoading = false.obs;
  final DioConsumer dioConsumer = sl<DioConsumer>();
  Rx<UserProfileModel?> studentProfile = Rx<UserProfileModel?>(null);
  User user = User();
  RxList<RidesModel> allRides = <RidesModel>[].obs;
  RxInt accptedDriverRides = 0.obs;
  RxInt startedRides = 0.obs;
  RxInt completedRides = 0.obs;
  RxInt rejectedRides = 0.obs;

  @override
  Future<void> onInit() async {
    getUserProfile();
    super.onInit();
  }

  Future<void> getUserProfile() async {
    isLoading.value = true;

    await user.loadId();

    try {
      final response =
          await dioConsumer.get("${EndPoints.user}${user.userId.value}");
      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.data);
        studentProfile.value = UserProfileModel.fromJson(responseData);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
