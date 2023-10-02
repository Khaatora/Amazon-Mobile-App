import 'package:amazon_e_commerce_clone/core/constants/app_colors.dart';
import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:amazon_e_commerce_clone/features/user/profile/view_models/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/dialogs/generic_dialog.dart';
import 'components/profile_greeting.dart';
import 'components/profile_orders.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<ProfileCubit>()
          ..initState(MainCubit.get(context).state.user.token),
        child: const ProfileView());
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
                // onSelected: (value) {
                //   switch (value) {
                //     case MenuItem.wishlists:
                //       break;
                //     case MenuItem.logout:
                //       break;
                //   }
                // },
                itemBuilder: (context) => [
                  // PopupMenuItem(
                  //   value: MenuItem.wishlists,
                  //   child: Row(
                  //     children: [
                  //       const Icon(Icons.shopping_bag_outlined),
                  //       const Spacer(),
                  //       Text(MenuItem.wishlists.name),
                  //     ],
                  //   ),
                  // ),
                  PopupMenuItem(
                    value: MenuItem.logout,
                    onTap: () async => await showGenericDialog<bool>(
                      context: context,
                      content: "Are you sure you want to log out?",
                      title: "Log Out",
                      optionsBuilder: () => {
                        "log out": true,
                        "Cancel": false,
                      },
                    ).then((value) {
                      if (value ?? false) {
                        MainCubit.get(context).signOut(() => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.authScreen, (route) => false),);
                      }
                    }),
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
      body: const Column(
        children: [
          ProfileGreeting(),
          SizedBox(
            height: 8,
          ),
          // ProfileTopButtons(),
          SizedBox(
            height: 20,
          ),
          Expanded(child: ProfileOrders()),
        ],
      ),
    );
  }
}
