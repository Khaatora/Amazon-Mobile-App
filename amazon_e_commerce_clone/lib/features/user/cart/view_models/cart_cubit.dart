import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/features/home/model/product_model.dart';
import '../../../../core/features/main/view_model/main_cubit.dart';
import '../../../../core/services/services_locator.dart';
import '../repository/i_cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {

  final ICartRepository cartRepository;

  CartCubit(this.cartRepository) : super(const CartState());

  static CartCubit get(context) => BlocProvider.of<CartCubit>(context);


  Future<void> addToCart(String token, Product product) async {
    if (isClosed) return;
    emit(state.copyWith(cartLoadingState: CartLoadingState.adding, message: "", ));
    final result = await cartRepository.addToCart(
        UpdateCartParams(product), token);
    if (isClosed) return;
    result.fold((l) {
      emit(
          state.copyWith(cartLoadingState: CartLoadingState.error, message: l.message));
    }, (r) {
      emit(state.copyWith(cartLoadingState: CartLoadingState.done));
      sl<MainCubit>().setCart(r.user.cart);
    });
  }

  Future<void> removeFromCart(String token, Product product) async {
    if (isClosed) return;
    emit(state.copyWith(cartLoadingState: CartLoadingState.removing, message: "", ));
    final result = await cartRepository.removeFromCart(
        UpdateCartParams(product), token);
    if (isClosed) return;
    result.fold((l) {
      emit(
          state.copyWith(cartLoadingState: CartLoadingState.error, message: l.message));
    }, (r) {
      emit(state.copyWith(cartLoadingState: CartLoadingState.done));
      sl<MainCubit>().setCart(r.user.cart);
    });
  }
}
