import 'dart:convert';

import 'package:drive_app/src/core/api/api_services.dart';
import 'package:drive_app/src/core/api/end_points.dart';
import 'package:drive_app/src/core/api/injection_container.dart';
import 'package:drive_app/src/core/user.dart';
import 'package:drive_app/src/feature/nav_bar/view/main/navbar_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginController extends GetxController {
  final studentId = TextEditingController();
  final password = TextEditingController();
  RxBool isLoading = false.obs;
  final DioConsumer dioConsumer = sl<DioConsumer>();

  RxBool unauthorized = false.obs;

  //validation
  String removeLeadingZero(String input) {
    if (input.startsWith("962")) {
      return input.substring(3); // Remove "962"
    } else if (input.startsWith("0")) {
      return input.replaceFirst(RegExp('^0+'), '');
    }
    return input;
  }

  validName(String? name) {
    if (name!.isEmpty) {
      return "Please fill the fields".tr;
    }
    return null;
  }

  vaildPassword(String? password) {
    if (!GetUtils.isLengthGreaterOrEqual(password, 5)) {
      return "password must be 6 length".tr;
    }
    return null;
  }

  User user = User();
  Future<void> login(context) async {
    isLoading.value = true;
    try {
      final body = jsonEncode({
        "studentId": studentId.text.trim(),
        "password": password.text.trim(),
      });
      final response = await dioConsumer.post(
        EndPoints.loginUser,
        body: body,
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.data);

        final token = jsonData['id'];
        await user.saveId(token);
        user.userId.value = token;

        isLoading.value = false;

        Get.offAll(const NavBarPage());
        studentId.clear();
        password.clear();
      } else {
        isLoading.value = false;

        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: 'Invalid login credentials '.tr,
          ),
        );

        unauthorized.value = true;
      }
    } catch (e) {
      isLoading.value = false;
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: 'loginError'.tr,
        ),
      );
      unauthorized.value = true;
    }
  }
}
