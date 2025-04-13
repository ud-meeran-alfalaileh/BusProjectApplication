import 'package:drive_app/src/core/user.dart';
import 'package:drive_app/src/core/utils/loading_page.dart';
import 'package:drive_app/src/feature/admin_nav_bar/view/main/admin_navbar_page.dart';
import 'package:drive_app/src/feature/driver_nav_bar/view/main/driver_navbar_page.dart';
import 'package:drive_app/src/feature/login/view/pages/login_page.dart';
import 'package:drive_app/src/feature/nav_bar/view/main/navbar_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainAppPage extends StatefulWidget {
  const MainAppPage({super.key});

  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  RxBool isLoading = true.obs;
  User user = User();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isLoading.value = true;
      Future.delayed(const Duration(seconds: 1)).whenComplete(() {
        initialState();
      });
    });

    super.initState();
  }

  Future<void> initialState() async {
    await user.loadId();
    await user.loadGender();
    // await user.clearId();
    if (user.adminID.value != 0) {
      Get.offAll(AdminNavbarPage());
    }
    if (user.driverID.value != 0) {
      Get.offAll(DriverNavBarPage());
    }
    if (user.userId.value != 0) {
      Get.offAll(NavBarPage());
    }
    if (user.userId.value == 0 &&
        user.driverID.value == 0 &&
        user.adminID.value == 0) {
      Get.offAll(LoginPage());
    }

    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loadingPage(context),
    );
  }
}
