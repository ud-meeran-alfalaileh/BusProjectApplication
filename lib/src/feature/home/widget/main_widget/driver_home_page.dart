import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/feature/location/controller/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  final LocationController controller = Get.put(LocationController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: SafeArea(
        child: SizedBox(
          width: context.screenWidth,
          height: context.screenHeight,
          child: Stack(
            children: [
              Container(
                width: context.screenWidth,
                height: context.screenHeight * .3,
                color: AppTheme.lightAppColors.primary,
                child: Image.asset(
                  'assets/image/logo (2).png',
                  width: context.screenWidth * .3,
                ),
              ),
              Positioned(
                  top: context.screenHeight * .25,
                  left: 30,
                  right: 30,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Today's trips",
                            style: TextStyle(
                              color: AppTheme.lightAppColors.background,
                              fontFamily: "Kanti",
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "see all",
                              style: TextStyle(
                                color: AppTheme.lightAppColors.background,
                                fontFamily: "Kanti",
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
