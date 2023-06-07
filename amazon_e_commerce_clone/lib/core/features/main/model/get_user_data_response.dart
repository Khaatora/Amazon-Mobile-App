import '../../../constants/keys.dart';
import 'app_user.dart';

class GetUserDataResponse{

  final AppUser user;

  GetUserDataResponse({required this.user});

  factory GetUserDataResponse.fromJson(Map<String, dynamic> json) {
    return GetUserDataResponse(
    user: AppUser(
      token: json[ApiKeys.token] ?? "",
      email: json[ApiKeys.email],
      address: json[ApiKeys.address],
      type: json[ApiKeys.type],
      name: json[ApiKeys.name],
    )
    );
  }
//
}