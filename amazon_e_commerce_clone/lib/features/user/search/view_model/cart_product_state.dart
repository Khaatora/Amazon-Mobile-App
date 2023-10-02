part of 'cart_product_cubit.dart';

class CartProductState extends Equatable {
  final Product? product;
  final String message;

//loaders
  final LoadingState loadingState;

  const CartProductState({
    this.message = '',
    this.product,
    this.loadingState = LoadingState.init,
  });

  CartProductState copyWith({
    Product? product,
    String? message,
    LoadingState? loadingState,
  }) {
    return CartProductState(
      product: product ?? this.product,
      message: message ?? this.message,
      loadingState: loadingState ?? this.loadingState,
    );
  }

  @override
  List get props => [
        product,
        message,
        loadingState,
      ];
}
