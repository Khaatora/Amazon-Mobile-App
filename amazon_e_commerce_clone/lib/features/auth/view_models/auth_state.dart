part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final Auth authType;

  const AuthState({
    this.authType = Auth.signin,
  });

  AuthState copyWith({
    Auth? authType,
  }) {
    return AuthState(
      authType: authType ?? this.authType,
    );
  }

  @override
  List<Object> get props => [
        authType,
      ];
}
