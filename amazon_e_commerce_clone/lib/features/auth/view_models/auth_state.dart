part of 'auth_cubit.dart';

enum Auth{
  signin,
  signup,
}

class AuthState extends Equatable {
  final Auth authType;
  final LoadingState loadingState;

  const AuthState({
    this.authType = Auth.signin,
    this.loadingState = LoadingState.init,
  });

  AuthState copyWith({
    Auth? authType,
    LoadingState? loadingState,
  }) {
    return AuthState(
      authType: authType ?? this.authType,
      loadingState: loadingState ?? this.loadingState,
    );
  }

  @override
  List<Object> get props => [
        authType,
        loadingState,
      ];
}
