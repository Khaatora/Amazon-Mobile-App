import 'dart:developer';

import 'package:amazon_e_commerce_clone/features/user/home/models/response_models/get_category_products_response.dart';
import 'package:amazon_e_commerce_clone/features/user/home/models/response_models/get_deal_of_the_day_response.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/api_paths.dart';
import '../../../../core/errors/exceptions/api/login_exceptions.dart';
import '../../../../core/errors/exceptions/server_exception.dart';
import '../../../../core/services/services_locator.dart';
import '../repository/i_home_repository.dart';

class HomeRemoteDataSource {


  Future<GetCategoryProductsResponse> getCategoryProducts(
      GetCategoryProductsParams params, String token) async {
    try {
      final response = await sl<Dio>().get(ApiPaths.getCategoryProductsUrl(),
          queryParameters: params.toJson(),
          options: Options(headers: {
            Headers.contentTypeHeader: "application/json; charset=UTF-8",
            "x-auth-token": token,
          }));
      if (response.statusCode == 200) {
        return GetCategoryProductsResponse.fromJson(response.data);
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

  Future<GetDealOfTheDayResponse> getDealOfTheDay(
      GetDealOfTheDayParams params, String token) async {
    try {
      final response = await sl<Dio>().get(ApiPaths.getDealOfTheDayUrl(),
          queryParameters: params.toJson(),
          options: Options(headers: {
            Headers.contentTypeHeader: "application/json; charset=UTF-8",
            "x-auth-token": token,
          }));
      if (response.statusCode == 200) {
        return GetDealOfTheDayResponse.fromJson(response.data);
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

  const HomeRemoteDataSource();
}
