part of 'user_home_cubit.dart';

class UserHomeState extends Equatable {
  final String message;
  final Product dealOfTheDay;

  //loaders
  final LoadingState loadingState;
  final LoadingState dealOfTheDayLoadingState;

  const UserHomeState({
    this.message = '',
    this.loadingState = LoadingState.init,
    this.dealOfTheDay = const Product(
        name: '',
        description: '',
        price: 0.0,
        quantity: 0,
        category: '',
        images: []),
    this.dealOfTheDayLoadingState = LoadingState.loading,
  });

  UserHomeState copyWith({
    String? message,
    Product? dealOfTheDay,
    LoadingState? loadingState,
    LoadingState? dealOfTheDayLoadingState,
  }) {
    return UserHomeState(
      message: message ?? this.message,
      loadingState: loadingState ?? this.loadingState,
      dealOfTheDay: dealOfTheDay ?? this.dealOfTheDay,
      dealOfTheDayLoadingState:
          dealOfTheDayLoadingState ?? this.dealOfTheDayLoadingState,
    );
  }

  @override
  List<Object> get props => [
        message,
        loadingState,
        dealOfTheDay,
        dealOfTheDayLoadingState,
      ];
}
