import 'dart:convert';
import 'dart:developer';
import 'package:amazon_e_commerce_clone/features/user/cart/models/response_models/remove_from_cart_response.dart';
import 'package:amazon_e_commerce_clone/features/user/cart/repository/i_cart_repository.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/api_paths.dart';
import '../../../../core/errors/exceptions/api/login_exceptions.dart';
import '../../../../core/errors/exceptions/server_exception.dart';
import '../../../../core/services/services_locator.dart';
import 'response_models/add_to_cart_response.dart';

class CartRemoteDataSource {



  Future<AddToCartResponse> addToCart(
       UpdateCartParams params, String token) async {
    try {
      final response = await sl<Dio>().post(ApiPaths.addToCartUrl(),
          data: jsonEncode(
            params.toJson(),
          ),
          options: Options(headers: {
            Headers.contentTypeHeader: "application/json; charset=UTF-8",
            "x-auth-token": token,
          }));
      if (response.statusCode == 200) {
        return AddToCartResponse.fromJson(response.data);
      } else {
        throw const InvalidTokenException();
      }
    } on DioException catch (error) {
      log("${error.message}\n${error.response?.data["error"]}, stacktrace: ${error.stackTrace}");
      switch (error.response?.statusCode) {
        case 500:
          throw InternalServerException(error.response?.data["error"]);
        case 401:
          throw InvalidTokenException(error.response?.data["msg"]);
        default:
          throw const GenericAPIException();
      }
    } catch (e) {
      log("$e");
      rethrow;
    }
  }

  Future<RemoveFromCartResponse> removeFromCart(
      UpdateCartParams params, String token) async {
    try {
      final response = await sl<Dio>().delete("${ApiPaths.removeFromCartUrl()}/${params.product.id}",
          options: Options(headers: {
            Headers.contentTypeHeader: "application/json; charset=UTF-8",
            "x-auth-token": token,
          }));
      if (response.statusCode == 200) {
        return RemoveFromCartResponse.fromJson(response.data);
      } else {
        throw const InvalidTokenException();
      }
    } on DioException catch (error) {
      log("${error.message}\n${error.response?.data["error"]}, stacktrace: ${error.stackTrace}");
      switch (error.response?.statusCode) {
        case 500:
          throw InternalServerException(error.response?.data["error"]);
        case 401:
          throw InvalidTokenException(error.response?.data["msg"]);
        default:
          throw const GenericAPIException();
      }
    } catch (e) {
      log("$e");
      rethrow;
    }
  }

  const CartRemoteDataSource();
}
