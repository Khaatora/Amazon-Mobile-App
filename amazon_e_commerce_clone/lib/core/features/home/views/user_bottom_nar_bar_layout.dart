import 'package:amazon_e_commerce_clone/core/constants/app_colors.dart';
import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;
import '../../../services/services_locator.dart';
import '../viewmodels/user_bottom_nav_bar_layout_cubit.dart';

class UserBottomNavBarLayout extends StatelessWidget {
  const UserBottomNavBarLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          if (!sl.isRegistered<UserBottomNavBarLayoutCubit>()) {
            sl.registerLazySingleton<UserBottomNavBarLayoutCubit>(() =>
                UserBottomNavBarLayoutCubit());
          }
          return sl<UserBottomNavBarLayoutCubit>();
        },
        child: const BottomNavBarView(),);
  }
}

class BottomNavBarView extends StatelessWidget {
  const BottomNavBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBottomNavBarLayoutCubit,
        UserBottomNavBarLayoutState>(
      buildWhen: (previous, current) =>
      current.currentIndex != previous.currentIndex,
      builder: (context, state) {
        return Scaffold(
          body: UserBottomNavBarLayoutCubit
              .get(context)
              .pages[state.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              selectedItemColor: AppColors.selectedNavBarColor,
              unselectedItemColor: AppColors.unselectedNavBarColor,
              backgroundColor: AppColors.backgroundColor,
              iconSize: 28,
              onTap: UserBottomNavBarLayoutCubit
                  .get(context)
                  .updateIndex,
              items: [
                //HOME
                BottomNavigationBarItem(
                  label: UserBottomNavScreen.values[0].name,
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
                //CART
                BottomNavigationBarItem(
                    label: UserBottomNavScreen.values[1].name,
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
                      child: BlocBuilder<MainCubit, MainState>(
                        buildWhen: (previous, current) =>
                        current.user.cart != previous.user.cart,
                        builder: (context, state) {
                          return badges.Badge(
                            badgeContent: Text("${state.user.cart.length}"),
                            badgeStyle: const badges.BadgeStyle(
                              elevation: 0,
                              badgeColor: Colors.white,
                            ),
                            child: const Icon(Icons.shopping_cart_outlined),);
                        },
                      ),
                    )),
                //ACCOUNT
                BottomNavigationBarItem(
                  label: UserBottomNavScreen.values[2].name,
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
                        Icons.person_outline_outlined,
                      )),
                )
              ]),
        );
      },
    );
  }
}
