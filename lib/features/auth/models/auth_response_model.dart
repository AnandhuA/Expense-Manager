class AuthResponseModel {
  final bool userExists;
  final String otp;
  final String? token;
  final String? nickname;

  AuthResponseModel({
    required this.userExists,
    required this.otp,
    this.token,
    this.nickname,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      userExists: json['user_exists'] ?? false,
      otp: json['otp'] ?? "",
      token: json['token'],
      nickname: json['nickname'],
    );
  }
}