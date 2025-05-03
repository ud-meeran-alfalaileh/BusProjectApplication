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
  // final List<RatingModel> ratings;
  final UserModel students;

  BookingModel({
    required this.bookingId,
    required this.ride,
    required this.studentId,
    required this.rideId,
    required this.rideStatus,
    required this.busDriverId,
    required this.busDriverName,
    // required this.ratings,
    required this.students,
    required this.isRated,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json['bookingId'] ?? 0,
      studentId: json['studentId'] ?? 1,
      students: UserModel.fromJsonRating(json['students']),
      rideId: json['rideId'] ?? 0,
      ride: RidesModel.fromJsonListfromJsonBooking(json['rides']),
      rideStatus: json['rideStatus'],
      busDriverId: json['busDriverId'] ?? 0,
      busDriverName: json['busDriverName'],
      isRated: json['isRated'],
      // ratings: RatingModel.fromJsonList(json['ratings']),
    );
  }

  static List<BookingModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => BookingModel.fromJson(e)).toList();
  }
}
