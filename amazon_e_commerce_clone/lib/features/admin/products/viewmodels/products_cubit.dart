import 'dart:developer';

import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/features/home/model/product_model.dart';
import '../../../../core/services/services_locator.dart';
import '../repository/i_products_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {

  final IProductsRepository productsRepository;

  ProductsCubit(this.productsRepository) : super(const ProductsState());

  static ProductsCubit get(context) => BlocProvider.of<ProductsCubit>(context);

  Future<void> getProducts(String token) async {
    if(isClosed) return;
    emit(state.copyWith(loadingState: LoadingState.loading, message: ""));
    final result = await productsRepository.getProducts(
      token,
    );
    if(isClosed)return;
    result.fold((l) {
      emit(state.copyWith(loadingState: LoadingState.error, message: l.message));
    }, (r) {
      emit(state.copyWith(loadingState: LoadingState.loaded, products: r.products));
    });
  }

  Future<void> deleteProduct(String id, String token) async {
    if(isClosed) return;
    emit(state.copyWith(loadingState: LoadingState.loading, message: ""));
    final result = await productsRepository.deleteProduct(DeleteProductParams(id),
      token,
    );
    result.fold((l) {
      if(isClosed) return;
      emit(state.copyWith(loadingState: LoadingState.error, message: l.message));
    }, (r) {
      if(isClosed) return;
      emit(state.copyWith(loadingState: LoadingState.loaded, products: List<Product>.from(state.products!)..removeWhere((product) => product.id == id)));
    });
  }

  void addProduct(Product product){
    log("adding");
    emit(state.copyWith(products: List<Product>.from(state.products!)..add(product)));
  }

  @override
  Future<void> close() {
    sl.unregister<ProductsCubit>();
    return super.close();
  }

}
