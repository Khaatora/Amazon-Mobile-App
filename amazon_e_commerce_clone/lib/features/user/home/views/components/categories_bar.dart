import 'package:amazon_e_commerce_clone/core/constants/app_images.dart';
import 'package:amazon_e_commerce_clone/core/constants/app_routes.dart';
import 'package:amazon_e_commerce_clone/core/global/size_config.dart';
import 'package:flutter/material.dart';

class CategoriesBar extends StatelessWidget {
  const CategoriesBar({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        itemCount: AppImages.categoryImages.length,
        scrollDirection: Axis.horizontal,
        itemExtent: SizeConfig.screenWidth*1/5,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _navigateToCategoryPage(AppImages.categoryImages[index]["title"]!, context),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      AppImages.categoryImages[index]["image"]!,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(AppImages.categoryImages[index]["title"]!,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),),
              ],
            ),
          );
        },
      ),
    );
  }

  void _navigateToCategoryPage(String category, BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.categoryScreen, arguments: category);
  }
}
