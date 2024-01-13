import 'package:amazon_e_commerce_clone/core/features/home/model/cart_product_model.dart';
import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';

import '../../../../core/services/services_locator.dart';
import '../repository/i_address_repository.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final IAddressRepository addressRepository;

  AddressCubit(this.addressRepository) : super(const AddressState());

  static AddressCubit get(context) => BlocProvider.of<AddressCubit>(context);

  void initState(List<PaymentItem> paymentItems) {
    emit(state.copyWith(
        paymentItems: paymentItems, loadingState: LoadingState.init));
  }

  void startPaymentProcess(String address) {
    if (isClosed) return;
    emit(state.copyWith(
      loadingState: LoadingState.loading,
    ));
  }

  Future<void> placeOrder(String address, List<CartItem> cart, double totalSum,
      String token) async {
    final result = await addressRepository.placeOrder(
        PlaceOrderParams(address: address, cart: cart, totalPrice: totalSum),
        token);
    if (isClosed) return;
    result.fold((l) {
      emit(state.copyWith(
        loadingState: LoadingState.error,
        message: l.message,
      ));
    }, (r) {
      emit(state.copyWith(loadingState: LoadingState.loaded));
      sl<MainCubit>().setCart(r.products);
    });
  }

  void showError(String message) {
    emit(state.copyWith(
      loadingState: LoadingState.error,
      message: message,
    ));
  }
}
