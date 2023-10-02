import 'package:flutter/foundation.dart';

import '../app_user.dart';


@immutable
class GetUserDataResponse {
  final AppUser user;

  const GetUserDataResponse({required this.user});

  factory GetUserDataResponse.fromJson(Map<String, dynamic> json) {
    return GetUserDataResponse(
      user: AppUser.fromJson(json),
    );
  }
//
}
