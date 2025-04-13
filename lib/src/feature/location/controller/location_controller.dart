import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final fromKey = GlobalKey<FormState>();

  RxBool isPickupLocation = true.obs;
  RxString title = "".obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  final List<String> allLocations = [
    "كلية التربية والآداب",
    "عمادة شؤون الطلاب",
    "كلية الصيدلة",
    "كلية الطب",
    "المستشفى",
    "إدارة الأعمال",
    "المكتبة",
    "الصالة الرياضية",
    "سكن طلاب المنح",
    "كلية إدارة الأعمال",
    "كلية التربية",
    "كلية الشريعة والقانون",
  ];

  final RxnString fromLocation = RxnString();
  final RxnString toLocation = RxnString();

  List<String> get firstList => allLocations;

  List<String> get secondList =>
      allLocations.where((item) => item != fromLocation.value).toList();

  void selectFirst(String? value) {
    fromLocation.value = value;
    if (toLocation.value == value) {
      toLocation.value = null;
    }
  }

  void selectSecond(String? value) {
    toLocation.value = value;
  }
}
