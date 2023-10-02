part of 'auth_cubit.dart';

enum Auth { signin, signup }

// enum UserType {
//   user,
//   admin,
// }

class AuthState extends Equatable {
  final Auth authType;
  final LoadingState loadingState;
  final UserType type;
  final String message;

  const AuthState({
    this.authType = Auth.signin,
    this.loadingState = LoadingState.init,
    this.message = "",
    this.type = UserType.user,
  });

  AuthState copyWith({
    Auth? authType,
    LoadingState? loadingState,
    String? message,
    UserType? type,
  }) {
    return AuthState(
      authType: authType ?? this.authType,
      loadingState: loadingState ?? this.loadingState,
      message: message ?? this.message,
      type: type ?? this.type,
    );
  }

  @override
  List<Object> get props => [
        authType,
        loadingState,
        type,
        message,
      ];
}
