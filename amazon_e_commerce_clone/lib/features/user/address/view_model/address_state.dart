part of 'address_cubit.dart';

class AddressState extends Equatable {
  final List<PaymentItem> paymentItems;
  final LoadingState loadingState;
  final String message;

  const AddressState({
    this.paymentItems = const [],
    this.loadingState = LoadingState.init,
    this.message = '',
  });

  AddressState copyWith({
    List<PaymentItem>? paymentItems,
    LoadingState? loadingState,
    String? message,
  }) {
    return AddressState(
      paymentItems: paymentItems ?? this.paymentItems,
      loadingState: loadingState ?? this.loadingState,
      message: message ?? this.message,
    );
  }

  @override
  List get props => [
        paymentItems,
        loadingState,
        message,
      ];
}
