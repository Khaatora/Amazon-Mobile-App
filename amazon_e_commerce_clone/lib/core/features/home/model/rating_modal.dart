import 'package:amazon_e_commerce_clone/core/constants/api_constants.dart';
import 'package:flutter/foundation.dart';

@immutable
class Rating {
  final String userId;
  final double? rating;

  const Rating({this.rating, required this.userId});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      userId: json[ApiProductKeys.userId],
      rating: (json[ApiProductKeys.rating] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiProductKeys.userId: userId,
      ApiProductKeys.rating: rating,
    };
  }
}
