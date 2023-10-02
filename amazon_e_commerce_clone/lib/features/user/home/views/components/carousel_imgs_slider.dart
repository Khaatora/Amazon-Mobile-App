import 'package:amazon_e_commerce_clone/core/constants/app_images.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImgsSlider extends StatelessWidget {
  const CarouselImgsSlider(
      {Key? key,
      this.images = AppImages.carouselImages,
      this.fit = BoxFit.cover,
      this.height = 200.0,
      this.width,
      this.carousalHeight = 200,
      this.autoPlay = true,
      this.enableInfiniteScroll = true})
      : super(key: key);

  final List<String> images;
  final BoxFit fit;
  final double height;
  final double? width;
  final double carousalHeight;
  final bool autoPlay;
  final bool enableInfiniteScroll;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images
          .map((img) => CachedNetworkImage(
                imageUrl: img,
                fit: fit,
                height: height,
                width: width,
                placeholder: (context, url) {
                  return const Loader();
                },
              ))
          .toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: carousalHeight,
        autoPlay: autoPlay,
        enableInfiniteScroll: enableInfiniteScroll,
      ),
    );
  }
}
