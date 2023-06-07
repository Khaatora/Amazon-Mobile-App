part of 'main_cubit.dart';

@immutable
class MainState {
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
  }) {
    return MainState(
        user: AppUser(
      type: type ?? user.type,
      address: address ?? user.address,
      email: email ?? user.email,
      token: token ?? user.token,
      name: name ?? user.name,
    ),
    loadingState: loadingState ?? this.loadingState,
    message: message ?? this.message);
  }
}


