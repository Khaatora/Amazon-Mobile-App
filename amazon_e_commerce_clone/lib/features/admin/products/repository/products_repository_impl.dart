import 'package:amazon_e_commerce_clone/core/errors/exceptions/server_exception.dart';
import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:amazon_e_commerce_clone/core/errors/failures/server_failure.dart';
import 'package:amazon_e_commerce_clone/features/admin/products/models/get_products_response.dart';
import 'package:amazon_e_commerce_clone/features/admin/products/models/remote_data_sources.dart';
import 'package:amazon_e_commerce_clone/features/admin/products/models/store_product_response.dart';
import 'package:amazon_e_commerce_clone/features/admin/products/repository/i_products_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

@immutable
class ProductsRepositoryImpl implements IProductsRepository {
  final CloudinaryRemoteDataSource cloudinaryRemoteDataSource;
  final ServerRemoteDataSource serverRemoteDataSource;

  const ProductsRepositoryImpl(
      this.cloudinaryRemoteDataSource, this.serverRemoteDataSource);

  @override
  Future<Either<IFailure, StoreProductResponse>> storeProductImgs(
      StoreProductImgsParams params, String token) async {
    try {
      final cloudinaryResponse =
          await cloudinaryRemoteDataSource.storeProduct(params);
      final serverResponse = await serverRemoteDataSource.storeProductData(
          cloudinaryResponse, token);
      return Right(serverResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<IFailure, GetProductsResponse>> getProducts(
      String token) async {
    try {
      final response = await serverRemoteDataSource.getProducts(token);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<IFailure, void>> deleteProduct(DeleteProductParams params, String token
      ) async {
    try {
      final response = await serverRemoteDataSource.deleteProduct(params,token);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
