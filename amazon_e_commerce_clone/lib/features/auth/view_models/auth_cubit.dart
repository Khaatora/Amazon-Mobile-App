import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/services_locator.dart';
import '../repository/i_auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IAuthRepository authRepository;

  AuthCubit(this.authRepository) : super(const AuthState());

  static AuthCubit get(BuildContext context) =>
      BlocProvider.of<AuthCubit>(context);

  Future<void> signup(String name, String email, String password,) async {
    if (isClosed) return;
    emit(state.copyWith(loadingState: LoadingState.loading, message: ""));
    final result = await authRepository.signup(SignupParams(
      email: email,
      name: name,
      password: password,
      type: state.type.name,
    ));
    if (isClosed) return;
    result.fold(
            (l) =>
            emit(state.copyWith(
                loadingState: LoadingState.error, message: l.message)),
            (r) => emit(state.copyWith(loadingState: LoadingState.loaded)));
  }

  void changeType(String type) {
    emit(state.copyWith(type: UserType.values.firstWhere((element) => element.name == type)));
  }

  // Future<void> singOut() async {
  //   if (isClosed) return;
  //   emit(state.copyWith(loadingState: LoadingState.loading, message: ""));
  //   final result = await authRepository.logout();
  //   if (isClosed) return;
  //   result.fold(
  //           (l) =>
  //           emit(state.copyWith(
  //               loadingState: LoadingState.error, message: l.message)),
  //           (r) =>
  //           emit(state.copyWith(
  //               loadingState: LoadingState.loaded, authType: Auth.signOut, message: '', type: Type.user)));
  // }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(loadingState: LoadingState.loading, message: ""));
    final result = await authRepository.login(LoginParams(
      email: email,
      password: password,
    ));
    result.fold(
            (l) =>
            emit(state.copyWith(
                loadingState: LoadingState.error, message: l.message)),
            (r) {
          sl<MainCubit>().setData(
            email: r.email,
            userId: r.id,
            type: r.type,
            token: r.token,
            name: r.name,
          );
          emit(state.copyWith(loadingState: LoadingState.loaded, type: UserType.values.firstWhere((element) => element.name == r.type)));
        });
  }

  void setAuthType(Auth auth) {
    if (state.authType != auth) {
      emit(state.copyWith(authType: auth, loadingState: LoadingState.init));
    }
  }

}
