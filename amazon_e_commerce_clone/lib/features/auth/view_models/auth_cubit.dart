import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  static AuthCubit get(BuildContext context) =>
      BlocProvider.of<AuthCubit>(context);

  void setAuthType(Auth auth) {
    if (state.authType != auth) {
      emit(state.copyWith(authType: auth));
    }
  }
}
