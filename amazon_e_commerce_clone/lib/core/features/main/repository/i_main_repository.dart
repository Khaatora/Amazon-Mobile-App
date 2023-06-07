import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:dartz/dartz.dart';

import '../model/get_user_data_response.dart';

abstract class IMainRepository{
  Future<Either<IFailure, GetUserDataResponse>> verifyToken(String token);
}