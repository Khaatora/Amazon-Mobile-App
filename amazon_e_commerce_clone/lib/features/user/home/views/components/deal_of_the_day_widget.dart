import 'package:amazon_e_commerce_clone/core/constants/app_colors.dart';
import 'package:amazon_e_commerce_clone/core/constants/app_routes.dart';
import 'package:amazon_e_commerce_clone/core/features/home/model/product_model.dart';
import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/loader.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/reloader.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/slidable_zoomable_gallery_widget.dart';
import 'package:amazon_e_commerce_clone/core/global/size_config.dart';
import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:amazon_e_commerce_clone/core/utils/general_utils.dart';
import 'package:amazon_e_commerce_clone/features/user/home/view_models/user_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DealOfTheDayWidget extends StatelessWidget {
  const DealOfTheDayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const SizeConfig().init(context);
    return BlocConsumer<UserHomeCubit, UserHomeState>(
      listener: (context, state) {
        if (state.dealOfTheDayLoadingState == LoadingState.error) {
          context.showCustomSnackBar(
              state.message, const Duration(seconds: 2), AppColors.red);
        }
      },
      listenWhen: (previous, current) =>
          current.dealOfTheDayLoadingState == LoadingState.error,
      builder: (context, state) {
        switch (state.dealOfTheDayLoadingState) {
          case LoadingState.init:
          case LoadingState.loading:
            return const Loader();
          case LoadingState.loaded:
            return GestureDetector(
              onTap: () =>
                  _navigateToProductDetailsScreens(context, state.dealOfTheDay),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   SizedBox(
                     width: double.infinity,
                     child: Text(
                       "Deal of the day!",
                       textAlign: TextAlign.center,
                       style: Theme.of(context).textTheme.titleLarge,
                     ),
                   ),
                  Text(
                    "Name: ${state.dealOfTheDay.name}",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "Price: \$${state.dealOfTheDay.price}",
                    overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Expanded(
                    child: SlidableZoomableGalleryWidget(
                        enableCurrentIndexIndicator: false, widgetWidth: SizeConfig.safeScreenWidth ,imageWidth: SizeConfig.safeScreenWidth, images: state.dealOfTheDay.images),
                  ),
                ],
              ),
            );
          case LoadingState.error:
            return ReloaderWidget(
                callBack: () => UserHomeCubit.get(context)
                    .getDealOfTheDay(MainCubit.get(context).state.user.token));
        }
      },
      buildWhen: (previous, current) =>
          current.dealOfTheDayLoadingState != previous.dealOfTheDayLoadingState,
    );
  }

  void _navigateToProductDetailsScreens(BuildContext context, Product product) {
    Navigator.pushNamed(context, AppRoutes.productDetailsScreen,
        arguments: product).then((value) => UserHomeCubit.get(context).refresh());
  }
}
