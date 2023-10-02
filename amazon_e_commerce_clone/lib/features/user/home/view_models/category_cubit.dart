import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:amazon_e_commerce_clone/features/user/home/repository/i_home_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/features/home/model/product_model.dart';
import '../../../../core/services/services_locator.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.homeRepository) : super(const CategoryState());

  final IHomeRepository homeRepository;

  static CategoryCubit get(context) => BlocProvider.of<CategoryCubit>(context);

  Future<void> initState(String category, String token) async {
    if (isClosed) return;
    emit(
        state.copyWith(category: category, products: null,loadingState: LoadingState.loading, message: ""));
    final result = await homeRepository.getCategoryProducts(
        GetCategoryProductsParams(category), token);
    if (isClosed) return;
    result.fold((l) {
      emit(
          state.copyWith(loadingState: LoadingState.error, message: l.message));
    },
        (r) => {
              emit(state.copyWith(
                loadingState: LoadingState.loaded,
                products: r.products,
              ))
            });
  }

  void refresh(){
    initState(state.category, sl<MainCubit>().state.user.token);
  }

}
