part of 'cart_cubit.dart';

class CartState extends Equatable {
  final CartLoadingState cartLoadingState;
  final String message;

  const CartState({
    this.cartLoadingState = CartLoadingState.init,
    this.message = '',
  });

  CartState copyWith({
    CartLoadingState? cartLoadingState,
    String? message,
  }) {
    return CartState(
      cartLoadingState: cartLoadingState ?? this.cartLoadingState,
      message: message ?? this.message,
    );
  }

  @override
  List get props => [
        cartLoadingState,
        message,
      ];
}
