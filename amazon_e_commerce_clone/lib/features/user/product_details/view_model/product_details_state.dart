part of 'product_details_cubit.dart';

class ProductDetailsState extends Equatable {
  final Product? product;
  final String message;
  final double userRating;
  final double avgRating;

  //loaders
  final LoadingState loadingState;
  final LoadingState addToCartLoadingState;

  const ProductDetailsState({
    this.loadingState = LoadingState.init,
    this.product,
    this.message = '',
    this.userRating = 0.0,
    this.avgRating = 0.0,
    this.addToCartLoadingState = LoadingState.init,
  });

  ProductDetailsState copyWith({
    LoadingState? loadingState,
    LoadingState? addToCartLoadingState,
    Product? product,
    String? message,
    double? userRating,
    double? avgRating,
  }) {
    return ProductDetailsState(
        loadingState: loadingState ?? this.loadingState,
        product: product ?? this.product,
        message: message ?? this.message,
        userRating: userRating ?? this.userRating,
        avgRating: avgRating ?? this.avgRating,
        addToCartLoadingState:
            addToCartLoadingState ?? this.addToCartLoadingState);
  }

  @override
  List get props => [
        loadingState,
        product,
        message,
        userRating,
        avgRating,
        addToCartLoadingState,
      ];
}
