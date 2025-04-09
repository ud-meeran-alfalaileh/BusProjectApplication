import 'dart:convert';
import 'dart:developer';

import 'package:drive_app/src/core/api/api_services.dart';
import 'package:drive_app/src/core/api/end_points.dart';
import 'package:drive_app/src/core/api/injection_container.dart';
import 'package:drive_app/src/core/api/status_code.dart';
import 'package:drive_app/src/core/user.dart';
import 'package:drive_app/src/feature/profile/model/admin_profile_model.dart';
import 'package:get/get.dart';

class AdminProfileController extends GetxController {
  RxBool isLoading = false.obs;
  final DioConsumer dioConsumer = sl<DioConsumer>();
  Rx<UserProfileModel?> adminProfile = Rx<UserProfileModel?>(null);
  User user = User();

  @override
  Future<void> onInit() async {
    getAdminProfile();
    super.onInit();
  }

  Future<void> getAdminProfile() async {
    isLoading.value = true;

    await user.loadId();

    try {
      final response = await dioConsumer
          .get("${EndPoints.adminProfile}${user.adminID.value}");
      if (response.statusCode == StatusCode.ok) {
        final responseData = jsonDecode(response.data);
        adminProfile.value = UserProfileModel.fromJson(responseData);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
