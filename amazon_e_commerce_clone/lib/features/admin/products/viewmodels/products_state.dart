part of 'products_cubit.dart';

class ProductsState extends Equatable {
  final List<Product>? products;
  final LoadingState loadingState;
  final String message;

  const ProductsState({
    this.products,
    this.loadingState = LoadingState.init,
    this.message ='',
  });

  ProductsState copyWith({
    List<Product>? products,
    LoadingState? loadingState,
    String? message,
  }) {
    return ProductsState(
      products: products ?? this.products,
      loadingState: loadingState ?? this.loadingState,
      message: message ?? this.message,
    );
  }

  @override
  List get props =>
      [
        products,
        loadingState,
        message,
      ];
}
