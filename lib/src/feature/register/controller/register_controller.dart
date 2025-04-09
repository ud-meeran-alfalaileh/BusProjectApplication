import 'dart:convert';
import 'dart:developer';

import 'package:drive_app/src/core/api/api_services.dart';
import 'package:drive_app/src/core/api/end_points.dart';
import 'package:drive_app/src/core/api/injection_container.dart';
import 'package:drive_app/src/core/user.dart';
import 'package:drive_app/src/feature/nav_bar/view/main/navbar_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegisterController extends GetxController {
  final DioConsumer dioConsumer = sl<DioConsumer>();

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final studentID = TextEditingController();
  final genderController = TextEditingController();
  final majorController = TextEditingController();
  var isLoading = false.obs;
  User user = User();

  vaildEmail(String? email) {
    if (!GetUtils.isEmail(email!)) {
      return "wrong Email".tr;
    }
    return null;
  }

  vaildGender() {
    if (genderController.text.isEmpty) {
      return "Selected gender".tr;
    }
    return null;
  }

  vaildMajor() {
    if (majorController.text.isEmpty) {
      return "Selected Major".tr;
    }
    return null;
  }

  vaildPassword(String? password) {
    if (!GetUtils.isLengthGreaterOrEqual(password, 8)) {
      return "password must be 6 length".tr;
    }
    return null;
  }

  validName(String? name) {
    if (name!.isEmpty) {
      return "Please fill the fields".tr;
    }
    return null;
  }

  Future<void> register(context) async {
    // Check if the context is still mounted before showing any SnackBars
    isLoading.value = true;
    var body = jsonEncode({
      "id": 0,
      "email": email.text.trim(),
      "name": name.text.trim(),
      "password": password.text.trim(),
      "studentId": studentID.text.trim(),
      "gender": genderController.text.trim(),
      "userType": "User",
      "major": majorController.text.trim(),
    });

    final response = await dioConsumer.post(
      EndPoints.signupUser,
      body: body,
    );
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.data);
        final token = jsonData['id'];

        await user.saveId(token);
        user.userId.value = token;
        isLoading.value = false;

        Get.offAll(const NavBarPage());

        password.clear();
      } else {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Something went wrong",
          ),
        );
        isLoading.value = false;
      }
    } catch (error) {
      isLoading.value = false;

      log(error.toString());
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: error.toString(),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
