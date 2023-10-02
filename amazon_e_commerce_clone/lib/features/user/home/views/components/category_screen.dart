import 'package:amazon_e_commerce_clone/core/constants/app_routes.dart';
import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/loader.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/reloader.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/slidable_zoomable_gallery_widget.dart';
import 'package:amazon_e_commerce_clone/core/utils/general_utils.dart';
import 'package:amazon_e_commerce_clone/features/user/home/view_models/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/utils/dialogs/generic_dialog.dart';
import '../../../../../core/utils/enums.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String category =
        ModalRoute.of(context)?.settings.arguments as String;
    return BlocProvider(
        create: (context) => sl<CategoryCubit>()
          ..initState(category, MainCubit.get(context).state.user.token),
        child: const CategoryView());
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.appBarGradient,
          ),
        ),
        actions: [
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
        title: BlocBuilder<CategoryCubit, CategoryState>(
          buildWhen: (previous, current) =>
              current.category != previous.category,
          builder: (context, state) {
            return Text(
              state.category,
              style: const TextStyle(color: AppColors.black),
            );
          },
        ),
      ),
      body: BlocConsumer<CategoryCubit, CategoryState>(
        listenWhen: (previous, current) =>
            current.loadingState != previous.loadingState,
        listener: (context, state) {
          if (state.loadingState == LoadingState.error) {
            context.showCustomSnackBar(
              state.message,
              const Duration(seconds: 2),
              AppColors.red,
            );
          }
        },
        builder: (context, state) {
          switch (state.loadingState) {
            case LoadingState.init:
            case LoadingState.loading:
            case LoadingState.loaded:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "keep shopping for ${state.category} items",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    state.products == null
                        ? const Expanded(child: Loader())
                        : Expanded(
                            child: SizedBox(
                              height: 160,
                              child: state.products!.isEmpty
                                  ? const Center(
                                      child: Text("No data for this category"),
                                    )
                                  : GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1,
                                              childAspectRatio:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          1 /
                                                          6),
                                              mainAxisSpacing: 10),
                                      itemCount: state.products!.length,
                                      itemBuilder: (context, index) {
                                        final product = state.products![index];
                                        return GestureDetector(
                                          onTap: () => Navigator.pushNamed(
                                              context,
                                              AppRoutes.productDetailsScreen,
                                              arguments: product).then((value) => CategoryCubit.get(context).refresh()),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 130,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              AppColors.black12,
                                                          width: 0.5)),
                                                  child: SlidableZoomableGalleryWidget(enableCurrentIndexIndicator: false,imageWidth: 180,images: product.images),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  product.name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ),
                  ],
                ),
              );
            case LoadingState.error:
              return ReloaderWidget(
                  callBack: () => CategoryCubit.get(context).initState(
                      state.category, MainCubit.get(context).state.user.token));
          }
        },
      ),
    );
  }
}
