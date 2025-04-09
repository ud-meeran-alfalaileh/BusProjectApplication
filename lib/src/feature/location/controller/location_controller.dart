import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class LocationController extends GetxController {
  RxString distance = ''.obs;
RxString duration = ''.obs;

  var initialPosition = const LatLng(31.900883058179527, 35.9346984671693).obs;
  var markers = <String, Marker>{}.obs;
  RxBool next = false.obs;
  final fromKey = GlobalKey<FormState>();

  RxBool isDone = false.obs;
  RxBool isPickupLocation = true.obs;
  RxString title = "".obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  TextEditingController pickupController = TextEditingController();
  TextEditingController dropoffController = TextEditingController();
  var isLoading = false.obs;
  final TextEditingController startLocationController = TextEditingController();
  final TextEditingController endLocationController = TextEditingController();
  RxSet<Polyline> polylines = RxSet<Polyline>();
  final RxList<LatLng> routeCoords = <LatLng>[].obs;
  final String apiKey = 'AIzaSyCJd4BGxCKDB6fhdYCVym7ZM7dM_8w0HuI';
  Rx<LatLng?> start = Rx<LatLng?>(null);
  Rx<LatLng?> end = Rx<LatLng?>(null);
  late GoogleMapController mapController;

  Future<void> updateMarkerPosition(
      double lat, double lng, String markerId, String title) async {
    final marker = Marker(
      markerId: MarkerId(markerId),
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: title),
      icon: markerId == 'start'
          ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
          : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    markers[markerId] = marker;
    if (markerId == 'start') initialPosition.value = LatLng(lat, lng);
  }

  cameraMove(double lat, double long, String markerId, String title) async {
    markers.remove(markerId);

    updateMarkerPosition(lat, long, markerId, title);
    try {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat, long), zoom: 15),
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getCurrentLocation(String type) async {
    isLoading.value = true;
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        Get.snackbar('Error', 'Location permission denied');
        isLoading.value = false;
        return;
      }
      Position position = await Geolocator.getCurrentPosition();
      initialPosition.value = LatLng(position.latitude, position.longitude);
      updateMarkerPosition(
          position.latitude, position.longitude, 'current', 'current');
    } catch (e) {
      Get.snackbar('Error', 'Failed to get location: $e');
    } finally {
      isLoading.value = false;
    }
  }

 Future<void> getRoutePoints() async {
  if (fromKey.currentState!.validate()) {
    try {
      String url =
          'https://maps.googleapis.com/maps/api/directions/json?origin=${start.value!.latitude},${start.value!.longitude}&destination=${end.value!.latitude},${end.value!.longitude}&mode=driving&key=$apiKey';

      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);
      log("Route response: ${data.toString()}");

      if (data['status'] == 'OK') {
        List<LatLng> polylineCoordinates = [];
        
        // Extract distance and duration
        var legs = data['routes'][0]['legs'][0];
        String distanceText = legs['distance']['text'];
        String durationText = legs['duration']['text'];

        // Update distance and duration
        distance.value = distanceText;
        duration.value = durationText;

        log("Distance: $distanceText");
        log("Duration: $durationText");

        var steps = legs['steps'];
        for (var step in steps) {
          String polyline = step['polyline']['points'];
          polylineCoordinates.addAll(PolylinePoints()
              .decodePolyline(polyline)
              .map((point) => LatLng(point.latitude, point.longitude)));
        }

        routeCoords.clear();
        routeCoords.addAll(polylineCoordinates);
        polylines.clear();
        polylines.add(
          Polyline(
            polylineId: PolylineId('route'),
            points: routeCoords,
            color: Colors.blue,
            width: 5,
          ),
        );

        isDone.value = true;

        // Move the camera to fit the route
        _moveCameraToRouteBounds(start.value!, end.value!);
      } else {
        log('Error: ${data['status']}');
      }
    } catch (e) {
      log('Error fetching route: $e');
    }
  }
}

  void _moveCameraToRouteBounds(LatLng start, LatLng end) {
    final bounds = LatLngBounds(
      southwest: LatLng(
        start.latitude < end.latitude ? start.latitude : end.latitude,
        start.longitude < end.longitude ? start.longitude : end.longitude,
      ),
      northeast: LatLng(
        start.latitude > end.latitude ? start.latitude : end.latitude,
        start.longitude > end.longitude ? start.longitude : end.longitude,
      ),
    );

    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 130));
  }
}
