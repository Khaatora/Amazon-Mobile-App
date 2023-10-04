import 'package:amazon_e_commerce_clone/features/admin/analytics/view/analytics_screen.dart';
import 'package:amazon_e_commerce_clone/features/admin/analytics/viewmodels/analytics_cubit.dart';
import 'package:amazon_e_commerce_clone/features/admin/orders/view/orders_screen.dart';
import 'package:amazon_e_commerce_clone/features/admin/orders/viewmodels/orders_cubit.dart';
import 'package:amazon_e_commerce_clone/features/admin/products/viewmodels/products_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/admin/products/view/products_screen.dart';
import '../../../services/services_locator.dart';
import '../../../utils/enums.dart';

part 'admin_bottom_nav_bar_layout_state.dart';

class AdminBottomNavBarLayoutCubit extends Cubit<AdminBottomNavBarLayoutState> {

  AdminBottomNavBarLayoutCubit() : super(const AdminBottomNavBarLayoutState());

  static AdminBottomNavBarLayoutCubit get(context) => BlocProvider.of<AdminBottomNavBarLayoutCubit>(context);

  List<Widget> get pages => [
    const ProductsScreen(),
    const OrdersScreen(),
    const AnalyticsScreen(),
  ];

  void updateIndex(int index){
    if(isClosed)return;
    emit(state.copyWith(currentIndex: index));
  }

  @override
  Future<void> close() {
    sl.unregister<AdminBottomNavBarLayoutCubit>();
    sl<ProductsCubit>().close();
    sl<OrdersCubit>().close();
    sl<AnalyticsCubit>().close();
    return super.close();
  }
}
