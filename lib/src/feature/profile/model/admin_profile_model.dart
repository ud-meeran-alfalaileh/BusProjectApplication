class UserProfileModel {
  int id;
  String email;
  String name;
  String gender;
  String userType;

  UserProfileModel({
    required this.id,
    required this.email,
    required this.name,
    required this.gender,
    required this.userType,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as int,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      gender: json['gender'] ?? "",
      userType: json['userType'] ?? '',
    );
  }

  static List<UserProfileModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => UserProfileModel.fromJson(json)).toList();
  }
}
