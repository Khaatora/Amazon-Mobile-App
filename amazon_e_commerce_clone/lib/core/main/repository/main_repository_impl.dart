import 'dart:developer';

import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:amazon_e_commerce_clone/core/errors/failures/server_failure.dart';
import 'package:amazon_e_commerce_clone/core/main/model/get_user_data_response.dart';
import 'package:amazon_e_commerce_clone/core/main/model/remote_data_source.dart';

import 'package:dartz/dartz.dart';

import 'i_main_repository.dart';

class MainRepositoryImpl implements IMainRepository{

  final RemoteDataSource remoteDataSource;


  MainRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<IFailure, GetUserDataResponse>> verifyToken(String token) async {
    try {
      final response = await remoteDataSource.verifyToken(token);
      return Right(response);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }

}