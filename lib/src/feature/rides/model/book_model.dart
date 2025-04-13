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
