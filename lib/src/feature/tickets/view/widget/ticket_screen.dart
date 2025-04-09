import 'package:drive_app/src/config/sizes/size_box_extension.dart';
import 'package:drive_app/src/config/sizes/sizes.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/feature/tickets/controller/ticket_controller.dart';
import 'package:drive_app/src/feature/tickets/view/widget/ticket_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TicketController());
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.bordercolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              shrinkWrap: true,
              itemCount: controller.tickets.length,
              separatorBuilder: (BuildContext context, int index) {
                return 20.0.kH;
              },
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: AppTheme.lightAppColors.background,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppTheme.lightAppColors.background,
                            backgroundImage:
                                AssetImage(controller.tickets[index].img),
                            radius: 30,
                          ),
                          10.0.kW,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TicketText.mainText(
                                  controller.tickets[index].title),
                              Row(
                                children: [
                                  Icon(
                                    Icons.timelapse_rounded,
                                    color: AppTheme.lightAppColors.bordercolor,
                                    size: 20,
                                  ),
                                  5.0.kW,
                                  TicketText.secText(
                                      "Time ${controller.tickets[index].duration}"),
                                ],
                              )
                            ],
                          ),
                          Spacer(),
                          //  GestureDetector(

                          //  )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              TicketText.timeText(
                                  controller.tickets[index].fromTime),
                              TicketText.ttText(
                                  controller.tickets[index].fromTitle),
                            ],
                          ),
                          Container(
                            width: context.screenWidth * .18,
                            height: 1,
                            color: AppTheme.lightAppColors.bordercolor,
                          ),
                          TicketText.durationText(
                              controller.tickets[index].duration),
                          Container(
                            width: context.screenWidth * .18,
                            height: 1,
                            color: AppTheme.lightAppColors.bordercolor,
                          ),
                          Column(
                            children: [
                              TicketText.timeText(
                                  controller.tickets[index].toTime),
                              TicketText.ttText(
                                  controller.tickets[index].toTitle),
                            ],
                          ),
                        ],
                      ),
                      10.0.kH,
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: AppTheme.lightAppColors.containercolor,
                          ),
                          10.0.kW,
                          TicketText.mainText(controller.tickets[index].type),
                          Spacer(),
                          TicketText.mainText(controller.tickets[index].price),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
            100.0.kH
          ],
        ),
      ),
    );
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40),
      width: context.screenWidth,
      height: context.screenHeight * .14,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
        color: AppTheme.lightAppColors.primary,
      ),
      child: Center(
        child: Text(
          "Tickets",
          style: TextStyle(
              color: AppTheme.lightAppColors.background,
              fontSize: 25,
              fontFamily: "Kanti",
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
