import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/features/home/model/product_model.dart';
import '../../../../core/features/main/view_model/main_cubit.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/enums.dart';
import '../../product_details/repository/i_product_details_repository.dart';

part 'cart_product_state.dart';

class CartProductCubit extends Cubit<CartProductState> {
  CartProductCubit(this.productDetailsRepository) : super(const CartProductState());

  final IProductDetailsRepository productDetailsRepository;

  Future<void> addToCart(String token, Product product) async {
    if (isClosed) return;
    emit(state.copyWith(loadingState: LoadingState.loading, message: "",));
    final result = await productDetailsRepository.addToCart(
        AddToCartParams(product), token);
    if (isClosed) return;
    result.fold((l) {
      emit(
          state.copyWith(loadingState: LoadingState.error, message: l.message));
    }, (r) {
      emit(state.copyWith(loadingState: LoadingState.loaded));
      sl<MainCubit>().setCart(r.user.cart);
    });
  }
}
