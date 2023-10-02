import 'dart:developer';

import 'package:amazon_e_commerce_clone/core/errors/exceptions/server_exception.dart';
import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:amazon_e_commerce_clone/core/errors/failures/server_failure.dart';
import 'package:amazon_e_commerce_clone/core/features/main/model/response_models/update_user_address_response.dart';
import 'package:amazon_e_commerce_clone/features/auth/models/local_data_source.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../errors/failures/cache_failure.dart';
import '../model/response_models/get_user_data_response.dart';
import '../model/remote_data_source.dart';
import 'i_main_repository.dart';

@immutable
class MainRepositoryImpl implements IMainRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  const MainRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<IFailure, GetUserDataResponse>> verifyToken(
      String token) async {
    try {
      final response = await remoteDataSource.verifyToken(token);
      return Right(response);
    } on ServerException catch (e) {
      log("Main Repository Error >>>>>> ${e.message}");
      return Left(ServerFailure(e.message));
    } catch (e) {
      log("Main Repository Error >>>>>> ${e.toString()}");
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<IFailure, UpdateUserAddressResponse>> updateUserAddress(
      UpdateUserAddressParams params, String token) async {
    try {
      final serverResponse = await remoteDataSource.updateAddress(params, token);
      return Right(serverResponse);
    } on ServerException catch (e) {
      log("Main Repository Error >>>>>> ${e.message}");
      return Left(ServerFailure(e.message));
    } catch (e) {
      log("Main Repository Error >>>>>> ${e.toString()}");
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<IFailure, void>> logout() async{
    try{
      await localDataSource.setToken("");
      return const Right(null);
    }
    catch(e){
      log("${e.toString()} <<>> $e");
      return left(const CacheFailure("unknown error occurred"));
    }
  }

  @override
  Future<String> getToken() async{
    try{
      final String token = await localDataSource.getToken();
      return token;
    }
    catch(e){
      log("${e.toString()} <<>> $e");
      return "";
    }
  }
}
