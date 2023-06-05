class SignupResponse {
  final String id;
  final String name;
  final String password;
  final String address;
  final String type;
  final String token;

  SignupResponse({
    required this.id,
    required this.name,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      id: json[SignupJsonKeys.id],
      name: json["name"],
      password: json["password"],
      address: json["address"],
      type: json["type"],
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      SignupJsonKeys.id: id,
      "name": name,
      "password": password,
      "address": address,
      "type": type,
      "token": token,
    };
  }
}

class SignupJsonKeys{
  static const String id = "_id";
}
