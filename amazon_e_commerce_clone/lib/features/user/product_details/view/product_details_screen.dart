import 'package:amazon_e_commerce_clone/core/features/home/model/product_model.dart';
import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/loader.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/reloader.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/slidable_zoomable_gallery_widget.dart';
import 'package:amazon_e_commerce_clone/core/utils/general_utils.dart';
import 'package:amazon_e_commerce_clone/features/user/product_details/view_model/product_details_cubit.dart';
import 'package:amazon_e_commerce_clone/features/user/search/view/components/reusable_components/stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/global/components/reusable_components/primary_custom_elevatedbutton.dart';
import '../../../../core/global/size_config.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/enums.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return BlocProvider(
        create: (context) => sl<ProductDetailsCubit>()
          ..initState(product, sl<MainCubit>().state.user.userId),
        child: const ProductDetailsView());
  }
}

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const SizeConfig().init(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.appBarGradient,
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.mic),
              ),
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                      height: 42,
                      margin: const EdgeInsets.only(left: 16),
                      alignment: Alignment.topLeft,
                      child: Material(
                        borderRadius: BorderRadius.circular(7),
                        elevation: 1.0,
                        child: TextFormField(
                          textInputAction: TextInputAction.search,
                          controller: _searchController,
                          onFieldSubmitted: _navigateToSearchScreen,
                          decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {
                                _navigateToSearchScreen(_searchController.text);
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Icon(
                                  Icons.search,
                                  color: AppColors.black,
                                  size: 24,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(top: 8),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide:
                                  BorderSide(color: Colors.black38, width: 1.0),
                            ),
                            hintText: "Search Amazon.in",
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          )),
      body: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listenWhen: (previous, current) =>
            current.loadingState == LoadingState.error ||
            current.addToCartLoadingState == LoadingState.error,
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
              return SingleChildScrollView(
                child: state.product == null
                    ? const Loader()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: Text(state.product!.id ?? "N/A",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium)),
                                StarsRatingBar(rating: state.avgRating),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
                            child: Text(
                              state.product!.name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SlidableZoomableGalleryWidget(
                                imageWidth: SizeConfig.safeScreenWidth, widgetWidth: SizeConfig.safeScreenWidth, images: state.product!.images),
                          ),
                          Container(
                            color: AppColors.black12,
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: RichText(
                                text: TextSpan(
                                    text: "Deal Price: ",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                  TextSpan(
                                      text: "\$${state.product!.price}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                      ))
                                ])),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(state.product!.description),
                          ),
                          Container(
                            color: AppColors.black12,
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PrimaryCustomElevatedButton(
                              text: "Buy Now",
                              backgroundColor: AppColors.secondaryColor,
                              foregroundColor: AppColors.white,
                              onPressed: () async {
                                await ProductDetailsCubit.get(context)
                                    .addToCart(
                                        MainCubit.get(context).state.user.token,
                                        state.product!);
                                _navigateToAddressScreen<double>(
                                    state.product!.price);
                              },
                              enabled: state.addToCartLoadingState ==
                                      LoadingState.loading
                                  ? false
                                  : true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PrimaryCustomElevatedButton(
                              text: "Add To Cart",
                              backgroundColor: AppColors.secondaryColor2,
                              foregroundColor: AppColors.black,
                              onPressed: () => ProductDetailsCubit.get(context)
                                  .addToCart(
                                      MainCubit.get(context).state.user.token,
                                      ModalRoute.of(context)!.settings.arguments
                                          as Product),
                              enabled: state.addToCartLoadingState ==
                                      LoadingState.loading
                                  ? false
                                  : true,
                            ),
                          ),
                          Container(
                            color: AppColors.black12,
                            height: 4,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Rate The Product",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: state.userRating,
                            minRating: 1,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4),
                            allowHalfRating: true,
                            direction: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return const Icon(
                                Icons.star,
                                color: AppColors.secondaryColor,
                              );
                            },
                            onRatingUpdate: (rating) {
                              ProductDetailsCubit.get(context).rateProduct(
                                MainCubit.get(context).state.user.token,
                                rating,
                              );
                            },
                          )
                        ],
                      ),
              );
            case LoadingState.error:
              return ReloaderWidget(
                callBack: () => ProductDetailsCubit.get(context).initState(
                    state.product!, sl<MainCubit>().state.user.userId),
              );
          }
        },
      ),
    );
  }

  void _navigateToSearchScreen(String query) {
    if (query.isNotEmpty) {
      Navigator.pushNamed(context, AppRoutes.searchScreen, arguments: query);
    }
  }

  void _navigateToAddressScreen<T>(T arguments) {
    Navigator.pushNamed(context, AppRoutes.addressScreen, arguments: arguments);
  }
}
