import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:amazon_e_commerce_clone/features/user/address/model/remote_data_source.dart';
import 'package:amazon_e_commerce_clone/features/user/address/model/response_models/place_order_response.dart';
import 'package:amazon_e_commerce_clone/features/user/address/repository/i_address_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions/server_exception.dart';
import '../../../../core/errors/failures/server_failure.dart';

class AddressRepositoryImpl implements IAddressRepository{

  final AddressRemoteDataSource remoteDataSource;


  const AddressRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<IFailure, PlaceOrderResponse>> placeOrder(PlaceOrderParams params, String token) async {
    try {
      final response = await remoteDataSource.order(params, token);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

}