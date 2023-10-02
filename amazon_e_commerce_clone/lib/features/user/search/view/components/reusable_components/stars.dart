import 'package:amazon_e_commerce_clone/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarsRatingBar extends StatelessWidget {
  const StarsRatingBar({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      direction: Axis.horizontal,
      itemCount: 5,
      itemSize: 16,
      rating: rating,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: AppColors.secondaryColor,
      ),
    );
  }
}
