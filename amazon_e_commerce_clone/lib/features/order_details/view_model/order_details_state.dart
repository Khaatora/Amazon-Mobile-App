part of 'order_details_cubit.dart';

class OrderDetailsState extends Equatable {
  final String message;
  final LoadingState changeOrderStatusLoadingState;
  final LoadingState loadingState;
  final Order? order;

  const OrderDetailsState({
    this.message = '',
    this.changeOrderStatusLoadingState = LoadingState.init,
    this.order,
    this.loadingState = LoadingState.init,
  });

  OrderDetailsState copyWith(
      {String? message,
      LoadingState? changeOrderStatusLoadingState,
      LoadingState? loadingState,
      Order? order}) {
    return OrderDetailsState(
      message: message ?? this.message,
      changeOrderStatusLoadingState:
          changeOrderStatusLoadingState ?? this.changeOrderStatusLoadingState,
      loadingState: loadingState ?? this.loadingState,
      order: order ?? this.order,
    );
  }

  @override
  List get props => [
        message,
        changeOrderStatusLoadingState,
        order,
        loadingState,
      ];
}
