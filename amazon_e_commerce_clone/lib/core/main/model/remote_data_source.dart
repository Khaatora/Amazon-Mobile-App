import 'dart:convert';
import 'dart:developer';

import 'package:amazon_e_commerce_clone/features/auth/models/login/login_response.dart';
import 'package:amazon_e_commerce_clone/features/auth/models/signup/signup_response.dart';
import 'package:amazon_e_commerce_clone/features/auth/repository/i_auth_repository.dart';
import 'package:dio/dio.dart';

import '../../constants/api_paths.dart';
import '../../errors/exceptions/api/signup_exceptions.dart';
import '../../errors/exceptions/server_exception.dart';
import '../../services/services_locator.dart';
import 'get_user_data_response.dart';

abstract class RemoteDataSource{
  Future<LoginResponse> login(LoginParams params);

  Future<SignupResponse> signup(SignupParams params);

  Future<GetUserDataResponse> verifyToken(String token);

}

class APIRemoteDataSource implements RemoteDataSource{
  @override
  Future<LoginResponse> login(LoginParams params) async {
    try {
      final response = await sl<Dio>().post(ApiConstants.signinUrl(),data: jsonEncode(params.toJson()));
      return LoginResponse.fromJson(response.data);
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

  @override
  Future<GetUserDataResponse> verifyToken(String token) async {
    try {
      final response = await sl<Dio>().post(ApiConstants.verifyTokenUrl(), options: Options(
        headers: {
          Headers.contentTypeHeader: "application/json; charset=UTF-8",
          "x-auth-token": token,
        }
      ));
      if(response.data){
        final dataResponse = await sl<Dio>().get(ApiConstants.getUserDataUrl(), options: Options(
          headers: {
            Headers.contentTypeHeader: "application/json; charset=UTF-8",
            "x-auth-token": token,
          }
        ));
        return GetUserDataResponse.fromJson(dataResponse.data);
      }
      else{
        throw const InvalidTokenException();
      }
    } on DioError catch(error){
      log("${error.message}, stacktrace: ${error.stackTrace}");
      switch(error.response!.statusCode){
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