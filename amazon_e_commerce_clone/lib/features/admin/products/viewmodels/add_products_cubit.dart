import 'dart:io';

import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/file_pickers/image_file_picker.dart';
import '../repository/i_products_repository.dart';

part 'add_products_state.dart';

class AddProductsCubit extends Cubit<AddProductsState> {
  final ImageFilePicker imageFilePicker;
  final IProductsRepository productsRepository;

  AddProductsCubit(this.imageFilePicker, this.productsRepository)
      : super(const AddProductsState());

  static AddProductsCubit get(context) =>
      BlocProvider.of<AddProductsCubit>(context);

  static const List<String> productCategories = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashion",
  ];

  void onCategoryChanged(String? selectedCategory) {
    emit(state.copyWith(selectedCategory: selectedCategory));
  }


  void selectImages() async {
    List<File> pickedImages = await imageFilePicker.pickImages() as List<File>;
    emit(state.copyWith(pickedImages: pickedImages, showImgValidator: pickedImages.isEmpty));
  }

  Future<void> addProduct(String name, String description, double price,
      double quantity, String token) async {
    if(state.pickedImages.isEmpty){
      emit(state.copyWith(showImgValidator: true));
      return;
    }
    emit(state.copyWith(loadingState: LoadingState.loading));
    final result = await productsRepository.storeProductImgs(
      StoreProductImgsParams(
          name: name,
          description: description,
          price: price,
          quantity: quantity,
          category: state.selectedCategory,
          images: state.pickedImages),
      token,
    );
    result.fold((l) {
      emit(state.copyWith(loadingState: LoadingState.error, message: l.message));
    }, (r) {
      emit(state.copyWith(loadingState: LoadingState.loaded));
    });
  }
}
