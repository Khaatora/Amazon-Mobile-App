part of 'auth_cubit.dart';

enum Auth{
  signin,
  signup,
}

class AuthState extends Equatable {
  final Auth authType;
  final LoadingState loadingState;
  final String message;

  const AuthState({
    this.authType = Auth.signin,
    this.loadingState = LoadingState.init,
    this.message = "",
  });

  AuthState copyWith({
    Auth? authType,
    LoadingState? loadingState,
    String? message,
  }) {
    return AuthState(
      authType: authType ?? this.authType,
      loadingState: loadingState ?? this.loadingState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        authType,
        loadingState,
      ];
}
