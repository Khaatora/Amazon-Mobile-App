import 'dart:developer';

import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/features/home/model/order_model.dart';
import '../../../../core/services/services_locator.dart';
import '../repository/i_orders_repository.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  static OrdersCubit get(context) => BlocProvider.of<OrdersCubit>(context);

  final IOrdersRepository ordersRepository;

  OrdersCubit(this.ordersRepository) : super(const OrdersState());

  void initState(String token) {
    getOrders(token);
  }

  Future<void> getOrders(String token) async {
    if (isClosed) return;
    emit(state.copyWith(getOrdersLoadingState: LoadingState.loading));
    final result =
        await ordersRepository.getAllOrders(const GetOrdersParams(), token);
    if (isClosed) return;
    result.fold((l) {
      emit(state.copyWith(
          getOrdersLoadingState: LoadingState.error, message: l.message));
    }, (r) {
      log("working, ${r.ordersData.length}");
      emit(state.copyWith(
          getOrdersLoadingState: LoadingState.loaded, orders: r.ordersData));
    });
  }

  void updateOrders(Order order) {
    state.orders!.removeWhere((element) => element.id == order.id);
    if(isClosed)return;
    emit(state.copyWith(orders: List<Order>.from(state.orders!)..add(order)));
  }

  @override
  Future<void> close() {
    sl.unregister<OrdersCubit>();
    return super.close();
  }
}
