import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:amazon_e_commerce_clone/core/main/model/get_user_data_response.dart';
import 'package:dartz/dartz.dart';

abstract class IMainRepository{
  Future<Either<IFailure, GetUserDataResponse>> verifyToken(String token);
}