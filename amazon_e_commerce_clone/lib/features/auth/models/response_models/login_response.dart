import 'package:flutter/foundation.dart';

@immutable
class LoginResponse{
  final String id;
  final String email;
  final String password;
  final String token;
  final String type;
  final String name;

  const LoginResponse({
    required this.id,
    required this.email,
    required this.password,
    required this.token,
    required this.type,
    required this.name,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json[SignupJsonKeys.id],
      email: json[SignupJsonKeys.email],
      password: json[SignupJsonKeys.password],
      token: json[SignupJsonKeys.token],
      type: json[SignupJsonKeys.type],
      name: json[SignupJsonKeys.name],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      SignupJsonKeys.id: id,
      SignupJsonKeys.password: password,
      SignupJsonKeys.token: token,
      SignupJsonKeys.type: type,
      SignupJsonKeys.email: email,
      SignupJsonKeys.name: name,
    };
  }
}

class SignupJsonKeys{
  static const String id = "_id";
  static const String token = "token";
  static const String email = "email";
  static const String password = "password";
  static const String type = "type";
  static const String name = "name";
}