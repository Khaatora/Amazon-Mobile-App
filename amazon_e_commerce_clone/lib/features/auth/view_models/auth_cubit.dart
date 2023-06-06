import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/i_auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IAuthRepository authRepository;

  AuthCubit(this.authRepository) : super(const AuthState());

  static AuthCubit get(BuildContext context) =>
      BlocProvider.of<AuthCubit>(context);

  Future<void> signup(String name, String email, String password) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    final result = await authRepository.signup(SignupParams(
      email: email,
      name: name,
      password: password,
    ));
    result.fold(
        (l) => emit(state.copyWith(
            loadingState: LoadingState.error, message: l.message)),
        (r) => emit(state.copyWith(loadingState: LoadingState.loaded)));
  }

  void setAuthType(Auth auth) {
    if (state.authType != auth) {
      emit(state.copyWith(authType: auth, loadingState: LoadingState.init));
    }
  }
}
