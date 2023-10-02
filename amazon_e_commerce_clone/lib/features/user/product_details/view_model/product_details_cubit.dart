import 'dart:developer';

import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/features/home/model/product_model.dart';
import '../../../../core/services/services_locator.dart';
import '../repository/i_product_details_repository.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final IProductDetailsRepository productDetailsRepository;

  ProductDetailsCubit(this.productDetailsRepository)
      : super(const ProductDetailsState());

  static ProductDetailsCubit get(context) =>
      BlocProvider.of<ProductDetailsCubit>(context);

  void initState(Product product, String userId) {
    if(isClosed) return;
    emit(state.copyWith(loadingState: LoadingState.init, addToCartLoadingState: LoadingState.init, message: ""));
    double userRating = 0.0;
    double avgRating = 0.0;
    if (product.ratings != null && product.ratings!.isNotEmpty) {
      double sumRating = 0.0;
      for (var rating in product.ratings!) {
        sumRating += rating.rating ?? 0.0;
        if (rating.userId == userId) {
          userRating = rating.rating ?? 0.0;
        }
      }
      avgRating = sumRating / (product.ratings!.length);
    }
    log("avgRating: $avgRating, userRating: $userRating");
    if (isClosed) return;
    emit(state.copyWith(
        loadingState: LoadingState.init,
        userRating: userRating,
        avgRating: avgRating,
      product: product,));
  }

  Future<void> rateProduct(String token, double rating) async {
    if (isClosed) return;
    emit(state.copyWith(loadingState: LoadingState.loading, message: "", addToCartLoadingState: LoadingState.init));
    final result = await productDetailsRepository.rateProduct(
        RateProductParams(rating: rating, product: state.product!), token);

    if (isClosed) return;
    result.fold((l) {
      emit(
          state.copyWith(loadingState: LoadingState.error, message: l.message));
    }, (response) {
      double avgRating = 0.0;
      if (response.product.ratings != null && response.product.ratings!.isNotEmpty) {
        double sumRating = 0.0;
        for (var rating in response.product.ratings!) {
          sumRating += rating.rating ?? 0.0;
        }
        avgRating = sumRating / (response.product.ratings!.length);
      }
      emit(state.copyWith(
          product: Product(
        name: state.product!.name,
        description: state.product!.description,
        price: state.product!.price,
        quantity: state.product!.quantity,
        category: state.product!.category,
        images: state.product!.images,
        id: state.product!.id,
      ),
          avgRating: avgRating,
          ));
    });
  }

  Future<void> addToCart(String token, Product product) async {
    if (isClosed) return;
    emit(state.copyWith(addToCartLoadingState: LoadingState.loading, message: "", loadingState: LoadingState.init));
    final result = await productDetailsRepository.addToCart(
        AddToCartParams(product), token);
    if (isClosed) return;
    result.fold((l) {
      emit(
          state.copyWith(addToCartLoadingState: LoadingState.error, message: l.message));
    }, (r) {
      emit(state.copyWith(addToCartLoadingState: LoadingState.loaded));
      sl<MainCubit>().setCart(r.user.cart);
    });
  }
}
