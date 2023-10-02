import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:amazon_e_commerce_clone/features/user/profile/models/remote_data_source.dart';
import 'package:amazon_e_commerce_clone/features/user/profile/models/response_models/get_orders_response.dart';
import 'package:amazon_e_commerce_clone/features/user/profile/repository/i_profile_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions/server_exception.dart';
import '../../../../core/errors/failures/server_failure.dart';

class ProfileRepositoryImpl implements IProfileRepository{

  final ProfileRemoteDataSource remoteDataSource;

  const ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<IFailure, GetOrdersResponse>> getAllOrders(GetOrdersParams params, String token
      ) async {
    try {
      final response = await remoteDataSource.getUserOrders(params, token);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

}