class SharedPrefsResponse{
  final String token;

  SharedPrefsResponse({required this.token});

  Map<String, dynamic> toJson() {
    return {
      "token": token,
    };
  }

  factory SharedPrefsResponse.fromJson(Map<String, dynamic> json) {
    return SharedPrefsResponse(
      token: json["token"] ?? "N/A",
    );
  }
}

class SharedPrefsJsonKeys{
  static const String token = "x-auth-token";
}