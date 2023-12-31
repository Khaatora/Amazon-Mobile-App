import 'dart:developer';
import 'package:amazon_e_commerce_clone/core/errors/exceptions/server_exception.dart';
import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:amazon_e_commerce_clone/core/errors/failures/server_failure.dart';
import 'package:amazon_e_commerce_clone/features/auth/models/local_data_source.dart';
import 'package:amazon_e_commerce_clone/features/auth/models/response_models/login_response.dart';
import 'package:amazon_e_commerce_clone/features/auth/models/response_models/signup_response.dart';
import 'package:amazon_e_commerce_clone/features/auth/repository/i_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../core/features/main/model/remote_data_source.dart';

@immutable
class AuthRepositoryImpl implements IAuthRepository{

  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  const AuthRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<IFailure, LoginResponse>> login(LoginParams params) async {
    try {
      final response = await remoteDataSource.login(params);
      localDataSource.setToken(response.token);
      return Right(response);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.message));
    } catch(e){
      log("${e.toString()} <<>> $e");
      return left(const ServerFailure("unknown error occurred"));
    }
  }

  @override
  Future<Either<IFailure, SignupResponse>> signup(SignupParams params) async {
    try {
      final response = await remoteDataSource.signup(params);
      return Right(response);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.message));
    } catch(e){
      log("${e.toString()} <<>> $e");
      return left(const ServerFailure("unknown error occurred"));
    }
  }


}