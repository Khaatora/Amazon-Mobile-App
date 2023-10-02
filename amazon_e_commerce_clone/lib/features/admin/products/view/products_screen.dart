import 'package:amazon_e_commerce_clone/core/constants/app_colors.dart';
import 'package:amazon_e_commerce_clone/core/constants/app_routes.dart';
import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/loader.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/reloader.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/slidable_zoomable_gallery_widget.dart';
import 'package:amazon_e_commerce_clone/core/utils/dialogs/generic_dialog.dart';
import 'package:amazon_e_commerce_clone/core/utils/general_utils.dart';
import 'package:amazon_e_commerce_clone/features/admin/products/viewmodels/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/global/size_config.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/enums.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: (sl.isRegistered<ProductsCubit>()
          ? sl<ProductsCubit>()
          : sl.registerSingleton(ProductsCubit(sl()))
        ..getProducts(MainCubit.get(context).state.user.token)),
      child: const ProductsView(),
    );
  }
}

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  Widget build(BuildContext context) {
    const SizeConfig().init(context);
    return BlocListener<ProductsCubit, ProductsState>(
      listenWhen: (previous, current) =>
          current.loadingState != previous.loadingState,
      listener: (context, state) {
        if (state.loadingState == LoadingState.error) {
          context.showCustomSnackBar(
              state.message, const Duration(seconds: 2), AppColors.red);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ProductsCubit, ProductsState>(
            buildWhen: (previous, current) =>
                current.products?.length != previous.products?.length ?? false,
            builder: (context, state) {
              return Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 16.0),
                child: Text(
                  "Added Products: ${state.products?.length ?? ""}",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: AppColors.teal),
                ),
              );
            },
          ),
          Expanded(
            child: Stack(
              children: [
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: AppColors.greyBackgroundColor,
                  ),
                  child: BlocBuilder<ProductsCubit, ProductsState>(
                    builder: (context, state) {
                      switch (state.loadingState) {
                        case LoadingState.init:
                        case LoadingState.loading:
                          return const Loader();
                        case LoadingState.loaded:
                          return state.products!.isEmpty
                              ? const Center(
                                  child: Text(
                                      "You have not added any products yet",
                                      textAlign: TextAlign.center))
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.separated(
                                    itemCount: state.products!.length,
                                    itemBuilder: (context, index) {
                                      final product = state.products![index];
                                      final isLoading = state.loadingState ==
                                          LoadingState.loading;
                                      double avgRating = 0.0;
                                      if (product.ratings != null &&
                                          product.ratings!.isNotEmpty) {
                                        double sumRating = 0.0;
                                        for (var rating in product.ratings!) {
                                          sumRating += rating.rating ?? 0.0;
                                        }
                                        avgRating = sumRating /
                                            (product.ratings!.length);
                                      }
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Table(
                                            columnWidths: const {
                                              1: FlexColumnWidth(1.5),
                                            },
                                            children: [
                                              TableRow(children: [
                                                const TableCell(
                                                  child: Text("Name: "),
                                                ),
                                                TableCell(
                                                    child: Text(product.name))
                                              ]),
                                              TableRow(children: [
                                                const TableCell(
                                                  child: Text("ID: "),
                                                ),
                                                TableCell(
                                                    child: Text(product.id!))
                                              ]),
                                              TableRow(children: [
                                                const TableCell(
                                                  child: Text("Total Price: "),
                                                ),
                                                TableCell(
                                                    child: Text(
                                                        "\$${product.price.toString()}"))
                                              ]),
                                              TableRow(children: [
                                                const TableCell(
                                                  child: Text("Quantity: "),
                                                ),
                                                TableCell(
                                                    child: Text(product.quantity
                                                        .toString()))
                                              ]),
                                              TableRow(children: [
                                                const TableCell(
                                                  child: Text("Rating: "),
                                                ),
                                                TableCell(
                                                    child:
                                                        Text("$avgRating/5.0"))
                                              ]),
                                              TableRow(children: [
                                                const TableCell(
                                                  child: Text("Description: "),
                                                ),
                                                TableCell(
                                                    child: Text(
                                                        product.description))
                                              ]),
                                            ],
                                          ),
                                          const Text("Images:"),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Stack(
                                            children: [
                                              SizedBox(
                                                height: 140,
                                                child:
                                                    SlidableZoomableGalleryWidget(
                                                        imageWidth: SizeConfig
                                                            .safeScreenWidth,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 8),
                                                        backgroundColor:
                                                            AppColors.white,
                                                        images: product.images),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: IconButton(
                                                  onPressed: isLoading
                                                      ? null
                                                      : () => showGenericDialog<
                                                              bool?>(
                                                            context: context,
                                                            title: "Delete",
                                                            content:
                                                                "Are you sure you want to delete product ${product.name}?\nProduct ID:${product.id}",
                                                            optionsBuilder: () {
                                                              return {
                                                                "Delete": true,
                                                                "Cancel": false,
                                                              };
                                                            },
                                                          ).then(
                                                              (deleteIsConfirmed) {
                                                            if (deleteIsConfirmed ??
                                                                false) {
                                                              ProductsCubit.get(
                                                                      context)
                                                                  .deleteProduct(
                                                                      product
                                                                          .id!,
                                                                      MainCubit.get(
                                                                              context)
                                                                          .state
                                                                          .user
                                                                          .token);
                                                            }
                                                          }),
                                                  disabledColor: AppColors
                                                      .greyBackgroundColor,
                                                  highlightColor: isLoading
                                                      ? AppColors
                                                          .greyBackgroundColor
                                                      : null,
                                                  tooltip: "Delete product",
                                                  icon:
                                                      const Icon(Icons.delete),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        height: 2,
                                        width: SizeConfig.safeScreenWidth,
                                        decoration: const BoxDecoration(
                                          color: AppColors.teal,
                                        ),
                                      );
                                    },
                                  ),
                                );
                        case LoadingState.error:
                          return ReloaderWidget(
                              callBack: () => ProductsCubit.get(context)
                                  .getProducts(
                                      MainCubit.get(context).state.user.token));
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: FloatingActionButton(
                        onPressed: _navigateToAddProductsScreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        tooltip: "Add Product",
                        child: const Icon(Icons.add)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToAddProductsScreen() {
    Navigator.pushNamed(context, AppRoutes.addProductsScreen);
  }
}
