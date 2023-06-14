import 'package:amazon_e_commerce_clone/core/constants/app_colors.dart';
import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:flutter/material.dart';

import 'components/profile_greeting.dart';
import 'components/profile_orders.dart';
import 'components/profile_top_buttons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ProfileView();
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.appBarGradient,
              ),
            ),
            actions: [
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.notifications_outlined),
              ),
              const Icon(Icons.search),
              PopupMenuButton<MenuItem>(
                onSelected: (value) {
                  switch(value){
                    case MenuItem.wishlists:
                      break;
                    case MenuItem.logout:
                      break;
                  }
                },
                itemBuilder: (context) => [
                   PopupMenuItem(
                    value: MenuItem.wishlists,
                    child:  Row(
                      children: [
                      const Icon(Icons.shopping_bag_outlined),
                      const Spacer(),
                      Text(MenuItem.wishlists.name),
                    ],),
                  ),PopupMenuItem(
                    value: MenuItem.logout,
                    child: Row(
                      children: [
                        const Icon(Icons.logout_outlined),
                        const Spacer(),
                        Text(MenuItem.logout.name),
                      ],
                    ),
                  ),
                ],
              )
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    "assets/images/amazon_in.png",
                    width: 120,
                    height: 45,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )),
      body: Column(
        children: const [
          ProfileGreeting(),
          SizedBox(
            height: 8,
          ),
          ProfileTopButtons(),
          SizedBox(
            height: 20,
          ),
          ProfileOrders(),
        ],
      ),
    );
  }
}
