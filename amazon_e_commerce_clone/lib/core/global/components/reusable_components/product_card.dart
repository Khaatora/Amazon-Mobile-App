import 'package:amazon_e_commerce_clone/core/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.imgLink, Key? key, this.fit, this.width, this.height}) : super(key: key);

  final String imgLink;
  final BoxFit? fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      color: Colors.white,
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.black12,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(5)),
        child: Container(
          width: width ?? 180,
          padding: const EdgeInsets.all(10),
          child: CachedNetworkImage(imageUrl: imgLink,
            fit: fit ?? BoxFit.contain,
            width: width ?? 180,
            height: height,),
        ),
      ),
    );
  }
}
