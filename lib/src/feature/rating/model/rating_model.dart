class RatingModel {
  final int ratingId;
  final int bookingId;
  final double ratingValue;
  final String? note;
  final int rideId;
  final String startTime;
  final String endTime;
  final String startDate;
  final String endDate;
  final String source;
  final String destination;
  final String status;
  final String gender;
  final int busDriverId;
  final String busDriverNamee;
  final int adminId;
  final int busNumber;

  RatingModel({
    required this.ratingId,
    required this.bookingId,
    required this.ratingValue,
    this.note,
    required this.rideId,
    required this.startTime,
    required this.endTime,
    required this.startDate,
    required this.endDate,
    required this.source,
    required this.destination,
    required this.status,
    required this.gender,
    required this.busDriverId,
    required this.busDriverNamee,
    required this.adminId,
    required this.busNumber,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      ratingId: json['ratingId'],
      bookingId: json['bookingId'],
      ratingValue: json['ratingValue'],
      note: json['note'],
      rideId: json['rideId'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      source: json['source'],
      destination: json['destination'],
      status: json['status'],
      gender: json['gender'],
      busDriverId: json['busDriverId'],
      busDriverNamee: json['busDriverNamee'],
      adminId: json['adminId'],
      busNumber: json['busNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ratingId': ratingId,
      'bookingId': bookingId,
      'ratingValue': ratingValue,
      'note': note,
      'rideId': rideId,
      'startTime': startTime,
      'endTime': endTime,
      'startDate': startDate,
      'endDate': endDate,
      'source': source,
      'destination': destination,
      'status': status,
      'gender': gender,
      'busDriverId': busDriverId,
      'busDriverNamee': busDriverNamee,
      'adminId': adminId,
      'busNumber': busNumber,
    };
  }

  static List<RatingModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => RatingModel.fromJson(json)).toList();
  }
}
