import 'package:amazon_e_commerce_clone/core/features/home/model/order_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/enums.dart';
import '../repository/i_order_details_repository.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {

  final IOrderDetailsRepository orderDetailsRepository;

  static OrderDetailsCubit get(context) => BlocProvider.of<OrderDetailsCubit>(context);

  OrderDetailsCubit(this.orderDetailsRepository) : super(const OrderDetailsState());


  void initState(Order order){
    if(isClosed) return;
    emit(state.copyWith(order: order, loadingState: LoadingState.loaded));
  }

  Future<void> updateOrderStatus(int status, String orderId ,String token) async{
    if(isClosed)return;
    emit(state.copyWith(changeOrderStatusLoadingState: LoadingState.loading));
    status = (status == 3 ? status : status+1);
    final result = await orderDetailsRepository.changeOrderStatus(ChangeOrderStatusParams(status: status, orderId: orderId), token);
    if(isClosed) return;
    result.fold((l) {
      emit(state.copyWith(changeOrderStatusLoadingState: LoadingState.error, message: l.message));
    }, (r) {
      emit(state.copyWith(changeOrderStatusLoadingState: LoadingState.loaded, order: r.order));
    });

  }
}
