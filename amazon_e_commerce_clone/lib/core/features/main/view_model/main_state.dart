part of 'main_cubit.dart';

@immutable
class MainState extends Equatable {
  final AppUser user;
  final LoadingState loadingState;
  final String message;

  const MainState(
      {this.user = const AppUser(
        token: "",
        email: "",
        address: "",
        type: "",
        name: "",
        userId: "",
        cart: [],
      ),
      this.loadingState = LoadingState.init,
      this.message = ""});

  MainState copyWith({
    String? email,
    String? token,
    String? address,
    String? type,
    String? name,
    LoadingState? loadingState,
    String? message,
    String? userId,
    List<CartItem>? cart,
  }) {
    return MainState(
        user: AppUser(
          type: type ?? user.type,
          address: address ?? user.address,
          email: email ?? user.email,
          token: token ?? user.token,
          name: name ?? user.name,
          userId: userId ?? user.userId,
          cart: cart ?? user.cart,
        ),
        loadingState: loadingState ?? this.loadingState,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [
        user,
        loadingState,
        message,
      ];
}
