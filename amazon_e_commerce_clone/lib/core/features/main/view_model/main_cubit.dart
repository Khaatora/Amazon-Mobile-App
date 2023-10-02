import 'dart:developer';
import 'package:amazon_e_commerce_clone/core/features/home/model/cart_product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/enums.dart';
import '../model/app_user.dart';
import '../repository/i_main_repository.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final IMainRepository mainRepository;

  MainCubit(this.mainRepository) : super(const MainState());

  static MainCubit get(context) => BlocProvider.of<MainCubit>(context);

  Future<void> initState() async {
    if (isClosed) return;
    emit(state.copyWith(loadingState: LoadingState.loading, message: ""));
    final tempToken = await mainRepository.getToken();
    if (isClosed) return;
    if (tempToken.isEmpty) {
      emit(state.copyWith(loadingState: LoadingState.loaded, token: ""));
      return;
    }
    final result = await mainRepository.verifyToken(tempToken);
    if (isClosed) return;
    result.fold(
        (l) => emit(state.copyWith(
              token: tempToken,
              loadingState: LoadingState.error,
              message: l.message,
            )), (r) {
      emit(state.copyWith(
        token: tempToken,
        loadingState: LoadingState.loaded,
        type: r.user.type,
        address: r.user.address,
        email: r.user.email,
        name: r.user.name,
        userId: r.user.userId,
        cart: r.user.cart,
      ));
    });
  }

  Future<void> signOut(VoidCallback callBack) async {
    if(isClosed)return;
    emit(state.copyWith(message: ""));
    final result = await mainRepository.logout();
    if (isClosed) return;
    result.fold(
        (l) => emit(state.copyWith(
            loadingState: LoadingState.error, message: l.message)), (r) {
      callBack();
      emit(state.copyWith(
          token: "",
          type: "",
          name: "",
          email: "",
          address: "",
          userId: "",
          cart: []));
    });
  }

  Future<String?> updateUserAddress(String address) async {
    final result = await mainRepository.updateUserAddress(
        UpdateUserAddressParams(address), state.user.token);

    if (isClosed) return "";
    result.fold((l) {
      return l.message;
    }, (r) {
      emit(state.copyWith(
        address: address,
      ));
      log("address set: $address");
      return "";
    });
  }

  void setData({
    String? email,
    String? name,
    String? token,
    String? type,
    String? address,
    String? userId,
    List<CartItem>? cart,
  }) {
    if (isClosed) return;
    emit(state.copyWith(
      email: email,
      name: name,
      token: token,
      type: type,
      address: address,
      userId: userId,
      cart: cart,
    ));
  }

  void setToken(String token) {
    state.copyWith(
      token: token,
    );
  }

  void setEmail(String email) {
    state.copyWith(
      email: email,
    );
  }

  void setType(String type) {
    state.copyWith(
      type: type,
    );
  }

  void setAddress(String address) {
    emit(state.copyWith(
      address: address,
    ));
  }

  void setCart(List<CartItem> cart) {
    emit(state.copyWith(
      cart: cart,
    ));
  }
}
