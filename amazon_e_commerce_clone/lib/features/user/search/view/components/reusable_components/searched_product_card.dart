import 'package:amazon_e_commerce_clone/core/constants/app_colors.dart';
import 'package:amazon_e_commerce_clone/core/features/home/model/product_model.dart';
import 'package:amazon_e_commerce_clone/core/global/size_config.dart';
import 'package:amazon_e_commerce_clone/features/user/search/view/components/reusable_components/stars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchedProductCard extends StatelessWidget {
  const SearchedProductCard({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    double sumRating = 0.0;
    double avgRating = 0.0;
    if (product.ratings != null && product.ratings!.isNotEmpty) {
      for (var rating in product.ratings!) {
        sumRating += rating.rating ?? 0.0;
      }
      avgRating = sumRating / (product.ratings!.length);
    }
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: product.images[0],
                height: 130,
                width: SizeConfig.safeBlockHorizontal * 33,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      StarsRatingBar(rating: avgRating),
                      Text(
                        "\$${product.price}",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "Eligible for FREE shipping",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      (product.quantity != 0
                          ? const Text(
                              "In Stock",
                              style: TextStyle(
                                  fontSize: 10, color: AppColors.teal),
                            )
                          : const Text(
                              "Out of Stock!",
                              style:
                                  TextStyle(fontSize: 10, color: AppColors.red),
                            )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
