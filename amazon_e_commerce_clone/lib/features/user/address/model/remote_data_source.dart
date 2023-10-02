import 'dart:convert';
import 'dart:developer';

import 'package:amazon_e_commerce_clone/features/user/address/model/response_models/place_order_response.dart';
import 'package:amazon_e_commerce_clone/features/user/address/repository/i_address_repository.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/api_paths.dart';
import '../../../../core/errors/exceptions/api/login_exceptions.dart';
import '../../../../core/errors/exceptions/server_exception.dart';
import '../../../../core/services/services_locator.dart';

class AddressRemoteDataSource{



  Future<PlaceOrderResponse> order(
      PlaceOrderParams params, String token) async {
    try {
      final response = await sl<Dio>().post(ApiPaths.orderUrl(),
          data: jsonEncode(
            params.toJson(),
          ),
          options: Options(headers: {
            Headers.contentTypeHeader: "application/json; charset=UTF-8",
            "x-auth-token": token,
          }));
      if (response.statusCode == 200) {
        return PlaceOrderResponse.fromJson(response.data);
      } else {
        throw const InvalidTokenException();
      }
    } on DioException catch (error) {
      log("${error.message}\n${error.response?.data["error"]}, stacktrace: ${error.stackTrace}");
      switch (error.response?.statusCode) {
        case 500:
          throw InternalServerException(error.response?.data["error"]);
        case 400:
          throw InvalidTokenException(error.response?.data["msg"]);
        default:
          throw const GenericAPIException();
      }
    } catch (e) {
      log("$e");
      rethrow;
    }
  }

  const AddressRemoteDataSource();
}