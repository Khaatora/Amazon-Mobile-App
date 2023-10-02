part of 'category_cubit.dart';

class CategoryState extends Equatable {
  final String category;
  final LoadingState loadingState;
  final List<Product>? products;
  final String message;

  const CategoryState(
      {this.category = '',
      this.loadingState = LoadingState.init,
      this.message = '',
      this.products});

  CategoryState copyWith({
    String? category,
    LoadingState? loadingState,
    String? message,
    List<Product>? products,
  }) {
    return CategoryState(
        category: category ?? this.category,
        loadingState: loadingState ?? this.loadingState,
        message: message ?? this.message,
        products: products ?? this.products);
  }

  @override
  List get props => [
        category,
        loadingState,
        message,
        products,
      ];
}
