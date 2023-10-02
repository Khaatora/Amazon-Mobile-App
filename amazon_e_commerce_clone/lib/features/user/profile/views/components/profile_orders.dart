import 'dart:developer';

import 'package:amazon_e_commerce_clone/core/constants/app_colors.dart';
import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/loader.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/product_card.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/reloader.dart';
import 'package:amazon_e_commerce_clone/features/user/profile/view_models/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/utils/enums.dart';

class ProfileOrders extends StatelessWidget {
  const ProfileOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          current.getOrdersLoadingState != previous.getOrdersLoadingState,
      builder: (context, state) {
        log("rebuilding, ${state.getOrdersLoadingState.toString()}");
        switch (state.getOrdersLoadingState) {
          case LoadingState.init:
          case LoadingState.loading:
          case LoadingState.loaded:
            return state.orders == null ? const Loader() : Center(
              child: Visibility(
                visible: state.orders!.isNotEmpty,
                replacement: const Center(child: Text("You Haven't Ordered Anything Yet"),),
                child: Column(
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
                        itemCount: state.orders!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => _navigateToOrderDetailsScreen(context, state.orders![index]),
                            child: ProductCard(
                                imgLink: state.orders![index].items[0].product.images[0]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          case LoadingState.error:
            return ReloaderWidget(
              callBack: () => ProfileCubit.get(context)
                  .getOrders(MainCubit.get(context).state.user.token),
            );
        }
      },
    );
  }

  void _navigateToOrderDetailsScreen<T>(BuildContext context, T arguments) {
    Navigator.pushNamed(context, AppRoutes.orderDetailsScreen, arguments: arguments);
  }
}
