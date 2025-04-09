import 'package:drive_app/src/feature/profile/model/admin_profile_model.dart';

class RidesModel {
  final int id;
  final String startTime;
  final String endTime;
  final String startDate;
  final String endDate;
  final String source;
  final String destination;
  final int busDriverId;
  final String status;
  final String gender;
  final int adminId;
  final int busNumber;
  final UserProfileModel? driver;

  RidesModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.startDate,
    required this.endDate,
    required this.source,
    required this.destination,
    required this.busDriverId,
    required this.status,
    required this.gender,
    required this.adminId,
    required this.busNumber,
    this.driver,
  });

  factory RidesModel.fromJson(Map<String, dynamic> json) {
    return RidesModel(
      id: json['id'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      source: json['source'],
      destination: json['destination'],
      busDriverId: json['busDriverId'],
      status: json['status'],
      gender: json['gender'],
      adminId: json['adminId'],
      busNumber: json['busNumber'],
    );
  }

  static List<RidesModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => RidesModel.fromJson(json)).toList();
  }

  /// `copyWith` method to create a new instance with updated values.
  RidesModel copyWith({
    int? id,
    String? startTime,
    String? endTime,
    String? startDate,
    String? endDate,
    String? source,
    String? destination,
    int? busDriverId,
    String? status,
    String? gender,
    int? adminId,
    int? busNumber,
    UserProfileModel? driver,
  }) {
    return RidesModel(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      source: source ?? this.source,
      destination: destination ?? this.destination,
      busDriverId: busDriverId ?? this.busDriverId,
      status: status ?? this.status,
      gender: gender ?? this.gender,
      adminId: adminId ?? this.adminId,
      busNumber: busNumber ?? this.busNumber,
      driver: driver ?? this.driver,
    );
  }
}
