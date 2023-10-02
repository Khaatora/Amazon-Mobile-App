part of 'orders_cubit.dart';

class OrdersState extends Equatable {
  final LoadingState getOrdersLoadingState;
  final List<Order>? orders;
  final String message;

  const OrdersState({
    this.getOrdersLoadingState = LoadingState.init,
    this.message = '',
    this.orders,
  });

  OrdersState copyWith(
      {LoadingState? getOrdersLoadingState,
      String? message,
      List<Order>? orders}) {
    return OrdersState(
      getOrdersLoadingState:
          getOrdersLoadingState ?? this.getOrdersLoadingState,
      message: message ?? this.message,
      orders: orders ?? this.orders,
    );
  }

  @override
  List get props => [
        getOrdersLoadingState,
        message,
        orders,
      ];
}
