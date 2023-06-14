import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../services/services_locator.dart';
import '../../../utils/enums.dart';
import '../viewmodels/admin_bottom_nav_bar_layout_cubit.dart';

class AdminBottomNavBarLayout extends StatelessWidget {
  const AdminBottomNavBarLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdminBottomNavBarLayoutCubit>(),
      child: const BottomNavBarView(),
    );
  }
}

class BottomNavBarView extends StatelessWidget {
  const BottomNavBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBottomNavBarLayoutCubit,
        AdminBottomNavBarLayoutState>(
      buildWhen: (previous, current) =>
          current.currentIndex != previous.currentIndex,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.appBarGradient,
              ),
            ),
            actions: [
              const Text(
                "Admin",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              PopupMenuButton<MenuItem>(
                onSelected: (value) {
                  switch (value) {
                    case MenuItem.wishlists:
                      break;
                    case MenuItem.logout:
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: MenuItem.wishlists,
                    child: Row(
                      children: [
                        const Icon(Icons.shopping_bag_outlined),
                        const Spacer(),
                        Text(MenuItem.wishlists.name),
                      ],
                    ),
                  ),
                  PopupMenuItem(
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
          ),
          body: AdminBottomNavBarLayoutCubit.get(context).pages[state.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              selectedItemColor: AppColors.selectedNavBarColor,
              unselectedItemColor: AppColors.unselectedNavBarColor,
              backgroundColor: AppColors.backgroundColor,
              iconSize: 28,
              onTap: AdminBottomNavBarLayoutCubit.get(context).updateIndex,
              items: [
                //Posts
                BottomNavigationBarItem(
                  label: AdminBottomNavScreen.values[0].name,
                  icon: Container(
                    width: state.bottomNavBarItemWidth,
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                        color: state.currentIndex == 0
                            ? AppColors.selectedNavBarColor
                            : AppColors.backgroundColor,
                        width: state.bottomNavBarItemBorderWidth,
                      )),
                    ),
                    child: const Icon(Icons.home_outlined),
                  ),
                ),
                //Analytics
                BottomNavigationBarItem(
                  label: AdminBottomNavScreen.values[1].name,
                  icon: Container(
                      width: state.bottomNavBarItemWidth,
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                          color: state.currentIndex == 1
                              ? AppColors.selectedNavBarColor
                              : AppColors.backgroundColor,
                          width: state.bottomNavBarItemBorderWidth,
                        )),
                      ),
                      child: const Icon(
                        Icons.analytics_outlined,
                      )),
                ),
                //Orders
                BottomNavigationBarItem (
                  label: AdminBottomNavScreen.values[2].name,
                  icon: Container(
                      width: state.bottomNavBarItemWidth,
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                              color: state.currentIndex == 2
                                  ? AppColors.selectedNavBarColor
                                  : AppColors.backgroundColor,
                              width: state.bottomNavBarItemBorderWidth,
                            )),
                      ),
                      child: const Icon(
                        Icons.all_inbox_outlined,
                      )),
                ),
              ]),
        );
      },
    );
  }
}
