import 'dart:convert';

import 'package:amazon_e_commerce_clone/core/errors/exceptions/api/login_exceptions.dart';
import 'package:amazon_e_commerce_clone/features/auth/models/login/login_response.dart';
import 'package:amazon_e_commerce_clone/features/auth/models/signup/signup_response.dart';
import 'package:amazon_e_commerce_clone/features/auth/repository/i_auth_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/services/services_locator.dart';

abstract class RemoteDataSource{
  Future<LoginResponse> login(LoginParams params);

  Future<SignupResponse> signup(SignupParams params);

}

class APIRemoteDataSource implements RemoteDataSource{
  @override
  Future<LoginResponse> login(LoginParams params) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<SignupResponse> signup(SignupParams params) async {
    final response = await sl<Dio>().post(ApiConstants.signupUrl(),data: jsonEncode(params.toJson()));
    switch(response.statusCode){
      case 200:
        return SignupResponse.fromJson(jsonDecode(response.data));
      case 400:
        throw InvalidCredentialsException(jsonDecode(response.data)["msg"]);
      case 500:
        throw InternalServerException(jsonDecode(response.data)["error"]);
      default:
        throw const GenericAPIException();
    }
  }

}