import 'dart:developer';

import 'package:amazon_e_commerce_clone/core/constants/app_routes.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/loader.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/slidable_zoomable_gallery_widget.dart';
import 'package:amazon_e_commerce_clone/features/admin/orders/viewmodels/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/features/main/view_model/main_cubit.dart';
import '../../../../core/global/components/reusable_components/reloader.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/enums.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: (sl.isRegistered<OrdersCubit>()
            ? sl<OrdersCubit>()
            : sl.registerSingleton(OrdersCubit(sl())))
          ..initState(MainCubit.get(context).state.user.token),
        child: const OrdersView());
  }
}

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          log("orders builder triggered");
          switch (state.getOrdersLoadingState) {
            case LoadingState.init:
            case LoadingState.loading:
              return const Loader();
            case LoadingState.loaded:
              return state.orders!.isEmpty
                  ? const Center(
                      child: Text("No one ordered yet",
                          textAlign: TextAlign.center),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //TODO: fix aspect ratio
                            crossAxisCount: 2,
                            childAspectRatio: MediaQuery.of(context)
                                    .size
                                    .width /
                                (MediaQuery.of(context).size.height * 3 / 5)),
                        itemCount: state.orders!.length,
                        itemBuilder: (context, index) {
                          final product = state.orders![index];
                          final List<String> images =
                              product.items.expand<String>((item) sync* {
                            for (String image in item.product.images) {
                              yield image;
                            }
                          }).toList();
                          return SizedBox(
                            height: 140,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.orderDetailsScreen,
                                      arguments: product);
                                },
                                child: SlidableZoomableGalleryWidget(
                                    widgetWidth: 140,
                                    imageWidth: 140,
                                    images: images,
                                    enableCurrentIndexIndicator: false)),
                          );
                        },
                      ),
                    );
            case LoadingState.error:
              return ReloaderWidget(
                  callBack: () => OrdersCubit.get(context)
                      .getOrders(MainCubit.get(context).state.user.token));
          }
        },
      ),
    );
  }
}
