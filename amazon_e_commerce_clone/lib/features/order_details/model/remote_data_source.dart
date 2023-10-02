

import 'dart:convert';
import 'dart:developer';

import 'package:amazon_e_commerce_clone/features/order_details/model/response_models/change_order_status_response.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/api_paths.dart';
import '../../../core/errors/exceptions/api/login_exceptions.dart';
import '../../../core/errors/exceptions/server_exception.dart';
import '../../../core/services/services_locator.dart';
import '../repository/i_order_details_repository.dart';

class OrderDetailsRemoteDataSource {

  Future<ChangeOrderStatusResponse> changeOrderStatus(
      ChangeOrderStatusParams params, String token) async {
    try {
      final response = await sl<Dio>().post(ApiPaths.adminChangeOrderStatusUrl(),
          data: jsonEncode(
            params.toJson(),
          ),
          options: Options(headers: {
            Headers.contentTypeHeader: "application/json; charset=UTF-8",
            "x-auth-token": token,
          }));
      if (response.statusCode == 200) {
        return ChangeOrderStatusResponse.fromJson(response.data);
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

  const OrderDetailsRemoteDataSource();
}
