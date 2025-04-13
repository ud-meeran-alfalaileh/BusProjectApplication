import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/core/user.dart';
import 'package:drive_app/src/core/utils/loading_page.dart';
import 'package:drive_app/src/feature/home/widget/main_widget/home_page.dart';
import 'package:drive_app/src/feature/login/view/pages/login_page.dart';
import 'package:drive_app/src/feature/nav_bar/controller/nav_bar_controller.dart';
import 'package:drive_app/src/feature/nav_bar/view/main/custome_navbar.dart';
import 'package:drive_app/src/feature/notification/controller/notification_controller.dart';
import 'package:drive_app/src/feature/profile/view/user_profile_page.dart';
import 'package:drive_app/src/feature/tickets/view/widget/ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  final NavController controller = Get.put(NavController());
  final notificationController = Get.put(NotificationController());

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
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (isLoading.value == false) {
        return Scaffold(
          body: user.userId.value == 0
              ? const LoginPage()
              : Stack(
                  children: [
                    Obx(() {
                      switch (controller.selectedIndex.value) {
                        case 0:
                          return const HomePage();
                        case 1:
                          return const TicketScreen();

                        case 2:
                          return const UserProfilePage();

                        default:
                          return Scaffold(
                            backgroundColor: AppTheme.lightAppColors.background,
                          );
                      }
                    }),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: context.screenHeight * .09,
                        decoration: BoxDecoration(
                          color: AppTheme.lightAppColors.background,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.lightAppColors.black
                                  .withValues(alpha: .1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            CustomNavItem(
                              icon: const Center(
                                child: Icon(
                                  size: 30,
                                  Icons.home_outlined,
                                ),
                              ),
                              onTap: () {
                                controller.setSelectedIndex(0);
                              },
                              isSelected: controller.selectedIndex.value == 0,
                            ),
                            CustomNavItem(
                              icon: Image.asset('assets/image/ticket.png'),
                              onTap: () {
                                controller.setSelectedIndex(1);
                                notificationController
                                    .getNotification(user.userId);
                              },
                              isSelected: controller.selectedIndex.value == 1,
                            ),
                            CustomNavItem(
                              icon: const Center(
                                child: Icon(
                                  size: 30,
                                  Icons.settings_outlined,
                                ),
                              ),
                              onTap: () {
                                controller.setSelectedIndex(2);
                              },
                              isSelected: controller.selectedIndex.value == 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      } else {
        return loadingPage(context);
      }
    });
  }
}
