import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/IFailures.dart';
import '../models/login/login_response.dart';
import '../models/signup/signup_response.dart';

abstract class IAuthRepository{
  Future<Either<IFailure, LoginResponse>> login(LoginParams params);

  Future<Either<IFailure, SignupResponse>> signup(SignupParams params);
}

class SignupParams {
  final String email;
  final String name;
  final String password;

  SignupParams({required this.email, required this.name, required this.password});

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "password": password,
    };
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}