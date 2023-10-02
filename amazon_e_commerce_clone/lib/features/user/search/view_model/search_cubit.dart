import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/features/home/model/product_model.dart';
import '../../../../core/services/services_locator.dart';
import '../repository/i_search_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {

  final ISearchRepository searchRepository;

  SearchCubit(this.searchRepository) : super(const SearchState());

  static SearchCubit get(context) => BlocProvider.of<SearchCubit>(context);

  Future<void> initState(String query, String token) async {
    search(query, token);
  }

  Future<void> search(String query, String token) async {
    if(isClosed) return;
    emit(state.copyWith(query: query, products: null));
    final result = await searchRepository.getSearchResults(GetSearchParams(query), token);
    if(isClosed) return;
    result.fold((l) {
      emit(state.copyWith(loadingState: LoadingState.error, message: l.message));
    }, (r) {
      emit(state.copyWith(products: r.products));
    });
  }

  void refresh(){
    search(state.query!, sl<MainCubit>().state.user.token);
  }

}
