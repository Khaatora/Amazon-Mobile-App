import 'package:amazon_e_commerce_clone/core/constants/api_constants.dart';
import 'package:amazon_e_commerce_clone/core/features/main/model/app_user.dart';

class AddToCartResponse {
  final AppUser user;

  const AddToCartResponse(this.user);

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) {
    return AddToCartResponse(
      AppUser.fromJson(json[ApiConstants.data]),
    );
  }
}
