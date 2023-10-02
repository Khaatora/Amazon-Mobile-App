part of 'profile_cubit.dart';

@immutable
class ProfileState extends Equatable{

  final String message;
  final List<Order>? orders;
  final LoadingState getOrdersLoadingState;

  @override
  List get props => [message,
    orders,
    getOrdersLoadingState,];

  const ProfileState({
     this.message ='',
    this.orders,
     this.getOrdersLoadingState = LoadingState.init,
  });

  ProfileState copyWith({
    String? message,
    List<Order>? orders,
    LoadingState? getOrdersLoadingState,
  }) {
    return ProfileState(
      message: message ?? this.message,
      orders: orders ?? this.orders,
      getOrdersLoadingState:
          getOrdersLoadingState ?? this.getOrdersLoadingState,
    );
  }
}
