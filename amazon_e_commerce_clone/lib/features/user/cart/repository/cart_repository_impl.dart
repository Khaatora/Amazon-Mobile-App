import 'package:amazon_e_commerce_clone/features/user/cart/models/response_models/remove_from_cart_response.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions/server_exception.dart';
import '../../../../core/errors/failures/IFailures.dart';
import '../../../../core/errors/failures/server_failure.dart';
import '../models/remote_data_source.dart';
import '../models/response_models/add_to_cart_response.dart';
import 'i_cart_repository.dart';

class CartRepositoryImpl implements ICartRepository {
  final CartRemoteDataSource serverRemoteDataSource;

  const CartRepositoryImpl(this.serverRemoteDataSource);

  @override
  Future<Either<IFailure, AddToCartResponse>> addToCart(
      UpdateCartParams params, String token) async {
    try {
      final response = await serverRemoteDataSource.addToCart(params, token);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<IFailure, RemoveFromCartResponse>> removeFromCart(
      UpdateCartParams params, String token) async {
    try {
      final response = await serverRemoteDataSource.removeFromCart(params, token);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
