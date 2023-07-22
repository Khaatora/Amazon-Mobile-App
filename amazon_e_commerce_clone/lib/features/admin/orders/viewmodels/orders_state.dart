part of 'orders_cubit.dart';

class OrdersState extends Equatable {
  final LoadingState loadingState;
  final String message;


  const OrdersState({this.loadingState = LoadingState.init, this.message = ''});



  OrdersState copyWith({
    LoadingState? loadingState,
    String? message,
  }) {
    return OrdersState(
      loadingState: loadingState ?? this.loadingState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
    loadingState,
    message,
  ];
}
