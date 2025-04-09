
import 'package:flutter/material.dart';
import 'package:drive_app/src/core/user.dart';
import 'package:get/get.dart';
 
class NavController extends GetxController {
  RxInt selectedIndex = 0.obs;
  final PageController pageController = PageController(initialPage: 0);
  User user = User();
  @override
  Future<void> onInit() async {
    setSelectedIndex(0);
    super.onInit();
  }
 

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
