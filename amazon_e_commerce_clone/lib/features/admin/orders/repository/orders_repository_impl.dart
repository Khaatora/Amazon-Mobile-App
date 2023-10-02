
import 'package:amazon_e_commerce_clone/features/admin/orders/models/remote_data_source.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions/server_exception.dart';
import '../../../../core/errors/failures/IFailures.dart';
import '../../../../core/errors/failures/server_failure.dart';
import '../models/response_models/get_orders_response.dart';
import 'i_orders_repository.dart';

class OrdersRepositoryImpl implements IOrdersRepository{

  final OrdersRemoteDataSource remoteDataSource;

  const OrdersRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<IFailure, GetOrdersResponse>> getAllOrders(GetOrdersParams params, String token
      ) async {
    try {
      final response = await remoteDataSource.getAdminOrders(params, token);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

}