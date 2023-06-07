class LoginResponse{
  final String id;
  final String email;
  final String password;
  final String token;

  LoginResponse({
    required this.id,
    required this.email,
    required this.password,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json[SignupJsonKeys.id],
      email: json["email"],
      password: json["password"],
      token: json["token"] ?? "N/A",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      SignupJsonKeys.id: id,
      "password": password,
      "token": token,
    };
  }
}

class SignupJsonKeys{
  static const String id = "_id";
}