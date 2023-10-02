import 'dart:developer';

import 'package:amazon_e_commerce_clone/features/user/search/model/response_models/get_search_results_response.dart';
import 'package:amazon_e_commerce_clone/features/user/search/repository/i_search_repository.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/api_paths.dart';
import '../../../../core/errors/exceptions/api/login_exceptions.dart';
import '../../../../core/errors/exceptions/server_exception.dart';
import '../../../../core/services/services_locator.dart';

class SearchRemoteDataSource{


  Future<GetSearchResultsResponse> getCategoryProducts(GetSearchParams params,String token) async {
    try {
      final response = await sl<Dio>().get("${ApiPaths.getSearchResultsUrl()}/${params.query}",options: Options(
          headers: {
            Headers.contentTypeHeader: "application/json; charset=UTF-8",
            "x-auth-token": token,
          }
      ));
      if(response.statusCode == 200){
        return GetSearchResultsResponse.fromJson(response.data);
      }
      else{
        throw const InvalidTokenException();
      }
    } on DioException catch(error){
      log("${error.message}\n${error.response?.data["error"]}, stacktrace: ${error.stackTrace}");
      switch(error.response!.statusCode){
        case 500:
          throw InternalServerException(error.response?.data["error"]);
        case 401:
          throw InvalidTokenException(error.response?.data["msg"]);
        default:
          throw const GenericAPIException();
      }
    }
    catch (e) {
      log("$e");
      rethrow;
    }
  }

  const SearchRemoteDataSource();
}