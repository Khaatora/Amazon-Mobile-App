import 'dart:convert';
import 'dart:developer';

import 'package:amazon_e_commerce_clone/features/auth/models/login/login_response.dart';
import 'package:amazon_e_commerce_clone/features/auth/models/signup/signup_response.dart';
import 'package:amazon_e_commerce_clone/features/auth/repository/i_auth_repository.dart';
import 'package:dio/dio.dart';

import '../../../constants/api_paths.dart';
import '../../../errors/exceptions/api/login_exceptions.dart';
import '../../../errors/exceptions/server_exception.dart';
import '../../../services/services_locator.dart';
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
      final response = await sl<Dio>().post(ApiPaths.signinUrl(),data: jsonEncode(params.toJson()));
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
      final response = await sl<Dio>().post(ApiPaths.verifyTokenUrl(), options: Options(
        headers: {
          Headers.contentTypeHeader: "application/json; charset=UTF-8",
          "x-auth-token": token,
        }
      ));
      if(response.data){
        final dataResponse = await sl<Dio>().get(ApiPaths.getUserDataUrl(), options: Options(
          headers: {
            Headers.contentTypeHeader: "application/json; charset=UTF-8",
            "x-auth-token": token,
          }
        ));
        log(dataResponse.data.toString());
        return GetUserDataResponse.fromJson(dataResponse.data);
      }
      else{
        throw const InvalidTokenException();
      }
    } on DioError catch(error){
      log("code: ${error.response?.statusCode},message: ${error.message},type: ${error.type}, stacktrace: ${error.stackTrace}");
      if(error.type == DioErrorType.connectionTimeout){
        throw const InternalServerException("Can't connect to servers at the moment, please try again later");
      }
      switch(error.response?.statusCode){
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
      final response = await sl<Dio>().post(ApiPaths.signupUrl(),data: jsonEncode(params.toJson()));
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