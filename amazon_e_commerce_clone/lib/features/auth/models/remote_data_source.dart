import 'dart:convert';
import 'dart:developer';

import 'package:amazon_e_commerce_clone/features/auth/models/login/login_response.dart';
import 'package:amazon_e_commerce_clone/features/auth/models/signup/signup_response.dart';
import 'package:amazon_e_commerce_clone/features/auth/repository/i_auth_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/errors/exceptions/api/signup_exceptions.dart';
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
    try {
      final response = await sl<Dio>().post(ApiConstants.signupUrl(),data: jsonEncode(params.toJson()));
      return SignupResponse.fromJson(response.data);
    } on DioError catch(error){
      switch(error.response!.statusCode){
        case 400:
          throw InvalidCredentialsException(error.response?.data["msg"]);
        case 500:
          throw InternalServerException(error.response?.data["error"]);
        default:
          throw const GenericAPIException();
      }
    }
    catch (e) {
      log("$e");
      rethrow;
    }
  }

}