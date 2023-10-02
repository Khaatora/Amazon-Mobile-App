import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:amazon_e_commerce_clone/features/user/search/model/remote_data_source.dart';

import 'package:amazon_e_commerce_clone/features/user/search/model/response_models/get_search_results_response.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions/server_exception.dart';
import '../../../../core/errors/failures/server_failure.dart';
import 'i_search_repository.dart';

class SearchRepositoryImpl implements ISearchRepository{

  final SearchRemoteDataSource remoteDataSource;


  const SearchRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<IFailure, GetSearchResultsResponse>> getSearchResults(GetSearchParams params, String token
      ) async {
    try {
      final response =
      await remoteDataSource.getCategoryProducts(params, token);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

}