import 'dart:developer';

import 'package:amazon_e_commerce_clone/core/features/home/model/order_model.dart';
import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/i_profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final IProfileRepository profileRepository;

  ProfileCubit(this.profileRepository) : super(const ProfileState());

  static ProfileCubit get(context) => BlocProvider.of<ProfileCubit>(context);

  void initState(String token){
    getOrders(token);
  }

  Future<void> getOrders(String token) async {
    if (isClosed) return;
    emit(state.copyWith(getOrdersLoadingState: LoadingState.loading));
    final result =
        await profileRepository.getAllOrders(const GetOrdersParams(), token);
    if(isClosed) return;
    result.fold((l) {
      emit(state.copyWith(
          getOrdersLoadingState: LoadingState.error, message: l.message));
    }, (r) {
      log("working, ${r.ordersData.length}");
      emit(state.copyWith(
          getOrdersLoadingState: LoadingState.loaded,
          orders: r.ordersData));
    });
  }
}
