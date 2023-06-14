import 'package:amazon_e_commerce_clone/core/constants/app_images.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImgsSlider extends StatelessWidget {
  const CarouselImgsSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: AppImages.carouselImages.map((img) => Builder(builder: (context) {
        return Image.network(img, fit: BoxFit.cover, height: 200,);
      },)).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200,
        autoPlay: true,
      ),
    );
  }
}
