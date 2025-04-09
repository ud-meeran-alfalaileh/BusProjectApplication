import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final RxInt userId = 0.obs;
  final RxInt driverID = 0.obs;
  final RxInt adminID = 0.obs;

  clearId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('LoginId');
    prefs.remove('loginDriver');
    prefs.remove('loginAdmin');
  }

  saveId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('LoginId', id); // Save the passed id
  }

  clearDriverId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loginDriver');
    userId.value = 0;
  }

  loadId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getInt('LoginId') ?? 0;
    driverID.value = prefs.getInt('loginDriver') ?? 0;
    adminID.value = prefs.getInt('loginAdmin') ?? 0;
    log(userId.value.toString());
    log(driverID.value.toString());
    log(adminID.value.toString());
  }

  loadIdAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    adminID.value = prefs.getInt('loginAdmin') ?? 0;
    log(adminID.value.toString());
  }

  saveDriverId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('loginDriver', id); // Save the passed id
  }

  clearAdminId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loginAmdin');
    userId.value = 0;
  }

  saveAdminId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('loginAdmin', id); // Save the passed id
    log(id.toString());
    loadIdAdmin();
  }
}
