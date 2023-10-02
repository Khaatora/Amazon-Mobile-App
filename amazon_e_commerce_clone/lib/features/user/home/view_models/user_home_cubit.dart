import 'package:amazon_e_commerce_clone/core/features/home/model/product_model.dart';
import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/services_locator.dart';
import '../repository/i_home_repository.dart';

part 'user_home_state.dart';

class UserHomeCubit extends Cubit<UserHomeState> {

  final IHomeRepository homeRepository;

  UserHomeCubit(this.homeRepository) : super(const UserHomeState());

  static UserHomeCubit get(context) => BlocProvider.of<UserHomeCubit>(context);

Future<void> getDealOfTheDay(String token) async{
  if(isClosed) return;
  emit(state.copyWith(message: '', dealOfTheDayLoadingState: LoadingState.loading));
  final result = await homeRepository.getDealOfTheDay(const GetDealOfTheDayParams(), token);
  if(isClosed)return;
  result.fold((l) {
    emit(state.copyWith(dealOfTheDayLoadingState: LoadingState.error, message: l.message));
  }, (r) {
    emit(state.copyWith(dealOfTheDay: r.product, dealOfTheDayLoadingState: LoadingState.loaded,));
  });
}

void refresh(){
  getDealOfTheDay(sl<MainCubit>().state.user.token);
}


}
