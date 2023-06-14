import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/user/cart/views/cart_screen.dart';
import '../../../../features/user/home/views/home_screen.dart';
import '../../../../features/user/profile/views/profile_screen.dart';

part 'user_bottom_nav_bar_layout_state.dart';

class UserBottomNavBarLayoutCubit extends Cubit<UserBottomNavBarLayoutState> {
  UserBottomNavBarLayoutCubit() : super(const UserBottomNavBarLayoutState());


  static UserBottomNavBarLayoutCubit get (context)=> BlocProvider.of<UserBottomNavBarLayoutCubit>(context);

  List<Widget> get pages => [
    const HomeScreen(),
    const CartScreen(),
    const AccountScreen(),
  ];

  void updateIndex(int index){
    emit(state.copyWith(currentIndex: index));
  }
}
