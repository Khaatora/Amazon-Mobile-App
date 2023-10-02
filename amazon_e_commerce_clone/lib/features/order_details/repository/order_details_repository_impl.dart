import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:amazon_e_commerce_clone/features/order_details/model/remote_data_source.dart';
import 'package:amazon_e_commerce_clone/features/order_details/model/response_models/change_order_status_response.dart';
import 'package:amazon_e_commerce_clone/features/order_details/repository/i_order_details_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/exceptions/server_exception.dart';
import '../../../core/errors/failures/server_failure.dart';

class OrderDetailsRepositoryImpl implements IOrderDetailsRepository {
  final OrderDetailsRemoteDataSource remoteDataSource;

  const OrderDetailsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<IFailure, ChangeOrderStatusResponse>> changeOrderStatus(
      ChangeOrderStatusParams params, String token) async {
    try {
      final response = await remoteDataSource.changeOrderStatus(params, token);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
