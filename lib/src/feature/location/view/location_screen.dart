// import 'dart:developer';

// import 'package:drive_app/src/config/sizes/size_box_extension.dart';
// import 'package:drive_app/src/config/sizes/sizes.dart';
// import 'package:drive_app/src/config/theme/theme.dart';
// import 'package:drive_app/src/core/utils/app_button.dart';
// import 'package:drive_app/src/feature/location/controller/location_controller.dart';
// import 'package:drive_app/src/feature/location/view/seet_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_places_flutter/google_places_flutter.dart';
// import 'package:google_places_flutter/model/prediction.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen(
//       {super.key,
//       required this.controller,
//       required this.type}); // Replace with your API Key

//   final LocationController controller;
//   final String type;

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   @override
//   void initState() {
//     if (mounted) {
//       if (widget.type != 'null') {
//         // widget.controller.isSec.value = true;
//         log(widget.type);

//         widget.controller.getRoutePoints();
//       }
 
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//         () => widget.controller.isLoading.value
//             ? Center(child: CircularProgressIndicator())
//             : Stack(
//                 children: [
//                   Obx(
//                     () => Padding(
//                       padding: EdgeInsets.only(top: context.screenHeight * .13),
//                       child: GoogleMap(
//                         initialCameraPosition: CameraPosition(
//                           target: widget.controller.initialPosition.value,
//                           zoom: 14,
//                         ),
//                         onMapCreated: (GoogleMapController controllerr) {
//                           widget.controller.mapController = controllerr;
//                         },
//                         markers: widget.controller.markers.values.toSet(),
//                         polylines: widget.controller.polylines
//                             .toSet(), // <- Wrap in Obx to listen for changes
//                       ),
//                     ),
//                   ),
//                   locationWidget(context),
//                   Container(
//                     padding: EdgeInsets.only(top: 5),
//                     width: context.screenWidth,
//                     height: context.screenHeight * .13,
//                     color: AppTheme.lightAppColors.primary,
//                     child: AppBar(
//                         centerTitle: true,
//                         title: Text(
//                           "Selecte Location",
//                           style: TextStyle(
//                               color: AppTheme.lightAppColors.background,
//                               fontFamily: "Kanti",
//                               fontSize: 24),
//                         ),
//                         backgroundColor: AppTheme.lightAppColors.primary,
//                         leading: IconButton(
//                             onPressed: () {
//                               widget.controller.isDone.value = false;
//                               if (context.mounted) {
//                                 Get.back();
//                               }
//                             },
//                             icon: Icon(
//                               Icons.close,
//                               color: AppTheme.lightAppColors.background,
//                             ))),
//                   ),
//                   // Positioned(
//                   //   bottom: 30,
//                   //   left: 10,
//                   //   right: 10,
//                   //   child: Obx(
//                   //     () => Container(
//                   //       padding: EdgeInsets.all(25),
//                   //       margin: EdgeInsets.all(25),
//                   //       width: context.screenWidth * .8,
//                   //       decoration: BoxDecoration(
//                   //         color: AppTheme.lightAppColors.background,
//                   //         borderRadius: BorderRadius.circular(10),
//                   //         boxShadow: [
//                   //           BoxShadow(
//                   //             color: AppTheme.lightAppColors.black
//                   //                 .withValues(alpha: 0.1),
//                   //             spreadRadius: 2,
//                   //             blurRadius: 5,
//                   //             offset: const Offset(0, 1),
//                   //           ),
//                   //         ],
//                   //       ),
//                   //       child: Column(
//                   //         children: [
//                   //           Text(
//                   //             "Distance: ${widget.controller.distance.value}",
//                   //             style: TextStyle(
//                   //                 fontSize: 18, fontWeight: FontWeight.bold),
//                   //           ),
//                   //           10.0.kH,
//                   //           Text(
//                   //             "Duration: ${widget.controller.duration.value}",
//                   //             style: TextStyle(
//                   //                 fontSize: 18, fontWeight: FontWeight.bold),
//                   //           ),
//                   //         ],
//                   //       ),
//                   //     ),
//                   //   ),
//                   // )
//                 ],
//               ),
//       ),
//     );
//   }

//   Positioned locationWidget(BuildContext context) {
//     return Positioned(
//       top: context.screenHeight * .16,
//       left: 20,
//       right: 20,
//       child: Form(
//         key: widget.controller.fromKey,
//         child: Column(
//           children: [
//             buildSearchField(
//               controller: widget.controller,
//               hint: 'Start Location',
//               testContrller: widget.controller.startLocationController,
//               onSelect: (Prediction prediction) {
//                 widget.controller.polylines.clear(); // Clear the route
//                 widget.controller.routeCoords
//                     .clear(); // Clear the route coordinates
//                 widget.controller.start(null); // Clear the start point

//                 widget.controller.cameraMove(
//                   double.parse(prediction.lat ?? '0.0'),
//                   double.parse(prediction.lng ?? '0.0'),
//                   'start',
//                   'Start Location',
//                 );
//                 widget.controller.start(LatLng(
//                   double.parse(prediction.lat ?? '0.0'),
//                   double.parse(prediction.lng ?? '0.0'),
//                 ));
//               },
//             ),
//             10.0.kH,
//             buildSearchField(
//               controller: widget.controller,
//               hint: 'End Location',
//               testContrller: widget.controller.endLocationController,
//               onSelect: (Prediction prediction) {
//                 widget.controller.polylines.clear(); // Clear the route
//                 widget.controller.routeCoords
//                     .clear(); // Clear the route coordinates
//                 widget.controller.end(null); // Clear the end point

//                 widget.controller.cameraMove(
//                   double.parse(prediction.lat ?? '0.0'),
//                   double.parse(prediction.lng ?? '0.0'),
//                   'end',
//                   'End Location',
//                 );

//                 widget.controller.end(LatLng(
//                   double.parse(prediction.lat ?? '0.0'),
//                   double.parse(prediction.lng ?? '0.0'),
//                 ));
//               },
//             ),
//             // : widget.controller.isSec.value == false
//             //     ? buildSearchField(
//             //         controller: widget.controller,
//             //         hint: 'Start Location',
//             //         testContrller: widget.controller.startLocationController,
//             //         onSelect: (Prediction prediction) {
//             //           widget.controller.polylines.clear(); // Clear the route
//             //           widget.controller.routeCoords
//             //               .clear(); // Clear the route coordinates
//             //           widget.controller.start(null); // Clear the start point
//             //           widget.controller.cameraMove(
//             //             double.parse(prediction.lat ?? '0.0'),
//             //             double.parse(prediction.lng ?? '0.0'),
//             //             'start',
//             //             'Start Location',
//             //           );
//             //           widget.controller.isSec.value = true;
//             //           widget.controller.start(LatLng(
//             //             double.parse(prediction.lat ?? '0.0'),
//             //             double.parse(prediction.lng ?? '0.0'),
//             //           ));
//             //         },
//             //       )
//             //     : Column(
//             //         children: [
//             //           buildSearchField(
//             //             controller: widget.controller,
//             //             hint: 'End Location',
//             //             testContrller:
//             //                 widget.controller.endLocationController,
//             //             onSelect: (Prediction prediction) {
//             //               widget.controller.polylines
//             //                   .clear(); // Clear the route
//             //               widget.controller.routeCoords
//             //                   .clear(); // Clear the route coordinates
//             //               widget.controller.end(null); // Clear the end point

//             //               widget.controller.cameraMove(
//             //                 double.parse(prediction.lat ?? '0.0'),
//             //                 double.parse(prediction.lng ?? '0.0'),
//             //                 'end',
//             //                 'End Location',
//             //               );

//             //               widget.controller.end(LatLng(
//             //                 double.parse(prediction.lat ?? '0.0'),
//             //                 double.parse(prediction.lng ?? '0.0'),
//             //               ));
//             //             },
//             //           ),
//             //         ],
//             //       ),
//             // : 30.0.kH,
//             // widget.controller.isSec.value
//             //     ?

//             20.0.kH,
//             Obx(() => widget.controller.isDone.value
//                 ? appButton(
//                     onTap: () {
//                       Get.to(SeatLocationScreen());
//                     },
//                     title: "Finish",
//                     width: 200)
//                 : appButton(
//                     onTap: () {
//                       widget.controller.getRoutePoints();
//                     },
//                     title: "Next",
//                     width: 200))
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget buildSearchField(
//     {required String hint,
//     required LocationController controller,
//     required TextEditingController testContrller,
//     required Function(Prediction) onSelect}) {
//   return GooglePlaceAutoCompleteTextField(
//     validator: (p0, p1) {
//       if (p0!.isEmpty) {
//         return "Please fill the form";
//       }
//       return null;
//     },
//     isCrossBtnShown: false,
//     textEditingController: testContrller,
//     googleAPIKey: controller.apiKey,
//     debounceTime: 800,
//     isLatLngRequired: true,
//     getPlaceDetailWithLatLng: onSelect,
//     itemClick: (Prediction prediction) {
//       testContrller.text = prediction.description ?? '';
//     },
//     inputDecoration: InputDecoration(
//       hintText: hint,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       filled: true,
//       fillColor: Colors.white,
//     ),
//   );
// }
