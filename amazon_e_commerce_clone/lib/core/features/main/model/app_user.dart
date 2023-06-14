import 'package:equatable/equatable.dart';

class AppUser extends Equatable{
  final String email;
  final String name;
  final String token;
  final String type;
  final String address;

  const AppUser({
    this.email = "",
    this.token = "",
    this.type = "",
    this.address = "",
    this.name = ""
  });

  @override
  List<Object?> get props => [
    email,
    name,
    token,
    type,
    address,
  ];
}