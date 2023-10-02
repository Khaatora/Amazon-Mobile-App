part of 'search_cubit.dart';

class SearchState extends Equatable {
  final String message;
  final LoadingState loadingState;
  final String? query;
  final List<Product>? products;

  const SearchState(
      {this.message = '',
      this.loadingState = LoadingState.init,
      this.query,
      this.products});

  SearchState copyWith({
    String? message,
    LoadingState? loadingState,
    String? query,
    List<Product>? products,
  }) {
    return SearchState(
      message: message ?? this.message,
      loadingState: loadingState ?? this.loadingState,
      query: query ?? this.query,
      products: products ?? this.products,
    );
  }

  @override
  List get props => [
        message,
        query,
        loadingState,
        products,
      ];
}
