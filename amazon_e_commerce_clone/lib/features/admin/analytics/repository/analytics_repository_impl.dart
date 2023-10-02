

import 'package:amazon_e_commerce_clone/features/admin/analytics/models/response_models/get_earnings_response.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions/server_exception.dart';
import '../../../../core/errors/failures/IFailures.dart';
import '../../../../core/errors/failures/server_failure.dart';
import '../models/remote_data_source.dart';
import 'i_analytics_repository.dart';

class AnalyticsRepositoryImpl implements IAnalyticsRepository{

  final AnalyticsRemoteDataSource remoteDataSource;

  const AnalyticsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<IFailure, GetEarningsResponse>> getEarnings(GetAnalyticsParams params, String token
      ) async {
    try {
      final response = await remoteDataSource.getEarnings(params, token);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

}