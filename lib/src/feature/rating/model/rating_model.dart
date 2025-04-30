import 'package:drive_app/src/feature/rides/model/book_model.dart';

class RatingModel {
  final int id;
  final double ratingValue;
  final int bookingId;
  final String note;
  BookModel? ride;

  RatingModel(
      {required this.id,
      required this.bookingId,
      required this.ratingValue,
      required this.note});

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
        id: json['id'] ?? 0,
        bookingId: json["bookingId"] ?? 0,
        ratingValue: json["ratingValue"].toDouble() ?? 0.0,
        note: json['note'] ?? '');
  }

  static List<RatingModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => RatingModel.fromJson(json)).toList();
  }
}
