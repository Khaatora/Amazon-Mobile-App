import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/admin/products/view/products_screen.dart';
import '../../../utils/enums.dart';

part 'admin_bottom_nav_bar_layout_state.dart';

class AdminBottomNavBarLayoutCubit extends Cubit<AdminBottomNavBarLayoutState> {

  AdminBottomNavBarLayoutCubit() : super(const AdminBottomNavBarLayoutState());

  static AdminBottomNavBarLayoutCubit get(context) => BlocProvider.of<AdminBottomNavBarLayoutCubit>(context);

  List<Widget> get pages => [
    const ProductsScreen(),
    const Center(child: Text("Analytics Page"),),
    const Center(child: Text("Orders Page"),),
  ];

  void updateIndex(int index){
    emit(state.copyWith(currentIndex: index));
  }
}
