import 'package:amazon_e_commerce_clone/core/constants/app_colors.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/product_card.dart';
import 'package:flutter/material.dart';

class ProfileOrders extends StatefulWidget {
  const ProfileOrders({Key? key}) : super(key: key);

  @override
  State<ProfileOrders> createState() => _ProfileOrdersState();
}

class _ProfileOrdersState extends State<ProfileOrders> {
  //temporary list for testing
  final List list = [
    "https://images.unsplash.com/photo-1685988755134-6d6457cb9ed3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1685988755134-6d6457cb9ed3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1685988755134-6d6457cb9ed3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1685988755134-6d6457cb9ed3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // orders text
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                "Your Orders",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                "See All",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.selectedNavBarColor,
                ),
              ),
            ),
          ],
        ),
        //display orders
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ProductCard(imgLink: list[index]);
            },
          ),
        ),
      ],
    );
  }
}
