import '../../../features.dart';

class UserModel extends User {
  UserModel({
    super.email,
    super.password,
    super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
