import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:amazon_e_commerce_clone/features/user/search/model/response_models/get_search_results_response.dart';
import 'package:dartz/dartz.dart';

abstract class ISearchRepository {
  Future<Either<IFailure, GetSearchResultsResponse>> getSearchResults(
      GetSearchParams params, String token);
}

class GetSearchParams {
  final String query;

  const GetSearchParams(this.query);

  Map<String, dynamic> toJson() {
    return {
      GetSearchResultsApiKeys.query: query,
    };
  }
}
