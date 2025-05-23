import 'package:drive_app/src/feature/profile/model/profile_model.dart';
import 'package:drive_app/src/feature/rides/model/rides_model.dart';

class BookModel {
  int id;
  int rideId;
  int studentId;
  String status;
  BookModel({
    required this.id,
    required this.rideId,
    required this.studentId,
    required this.status,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      status: json['status'],
      rideId: json['rideId'],
      studentId: json['studentId'],
    );
  }

  static List<BookModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => BookModel.fromJson(json)).toList();
  }
}

class BookingModel {
  final int bookingId;
  final int studentId;
  final List<RidesModel> ride;
  String rideStatus;
  final int busDriverId;
  final int rideId;
  final String busDriverName;
  final bool isRated;
 
  BookingModel({
    required this.bookingId,
    required this.ride,
    required this.studentId,
    required this.rideId,
    required this.rideStatus,
    required this.busDriverId,
    required this.busDriverName,
    required this.isRated,
   });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json['bookingId'],
      studentId: json['studentId'],
      rideId: json['rideId'],
      ride: RidesModel.fromJsonListfromJsonBooking(json['rides']),
      rideStatus: json['rideStatus'],
      busDriverId: json['busDriverId'],
      busDriverName: json['busDriverName'],
      isRated: json['isRated'],
     );
  }

  static List<BookingModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => BookingModel.fromJson(e)).toList();
  }
}
