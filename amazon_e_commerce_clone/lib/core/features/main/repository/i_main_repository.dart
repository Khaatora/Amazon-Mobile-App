import 'package:amazon_e_commerce_clone/core/constants/keys.dart';
import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:amazon_e_commerce_clone/core/features/main/model/response_models/update_user_address_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../model/response_models/get_user_data_response.dart';

abstract class IMainRepository {
  Future<Either<IFailure, GetUserDataResponse>> verifyToken(String token);

  Future<String> getToken();

  Future<Either<IFailure, void>> logout();

  Future<Either<IFailure, UpdateUserAddressResponse>> updateUserAddress(
      UpdateUserAddressParams params, String token);
}

@immutable
class UpdateUserAddressParams {
  final String address;

  const UpdateUserAddressParams(this.address);

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.address: address,
    };
  }
}
