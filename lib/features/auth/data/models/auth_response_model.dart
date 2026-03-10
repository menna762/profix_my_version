import 'user_model.dart';

class AuthResponseModel {
  final bool success;
  final String? token;
  final UserModel user;

  AuthResponseModel({
    required this.success,
    required this.user,
    this.token,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      success: json['success'] == true,
      token: json['token'],
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  // Constructor for direct response format
  AuthResponseModel.direct({
    required this.success,
    required this.user,
    this.token,
  });
}

