import 'dart:convert';
import 'dart:developer';

import 'package:amazon_e_commerce_clone/features/admin/orders/models/response_models/get_orders_response.dart';
import 'package:amazon_e_commerce_clone/features/admin/orders/repository/i_orders_repository.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/api_paths.dart';
import '../../../../core/errors/exceptions/api/login_exceptions.dart';
import '../../../../core/errors/exceptions/server_exception.dart';
import '../../../../core/services/services_locator.dart';

class OrdersRemoteDataSource{

  Future<GetOrdersResponse> getAdminOrders(
      GetOrdersParams params, String token) async {
    try {
      final response = await sl<Dio>().get(ApiPaths.adminGetOrdersUrl(),
          data: jsonEncode(
            params.toJson(),
          ),
          options: Options(headers: {
            Headers.contentTypeHeader: "application/json; charset=UTF-8",
            "x-auth-token": token,
          }));
      if (response.statusCode == 200) {
        return GetOrdersResponse.fromJson(response.data);
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

  const OrdersRemoteDataSource();
}