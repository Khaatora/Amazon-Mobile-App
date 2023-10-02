import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/features/main/model/app_user.dart';

class RemoveFromCartResponse {
  final AppUser user;

  const RemoveFromCartResponse(this.user);

  factory RemoveFromCartResponse.fromJson(Map<String, dynamic> json) {
    return RemoveFromCartResponse(
      AppUser.fromJson(json[ApiConstants.data]),
    );
  }
}