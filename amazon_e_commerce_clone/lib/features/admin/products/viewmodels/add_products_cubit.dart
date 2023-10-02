import 'dart:io';
import 'package:amazon_e_commerce_clone/core/constants/app_categories.dart';
import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:amazon_e_commerce_clone/features/admin/products/viewmodels/products_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/file_pickers/image_file_picker.dart';
import '../../../../core/services/services_locator.dart';
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
    AppCategories.Mobiles,
    AppCategories.Essentials,
    AppCategories.Appliances,
    AppCategories.Books,
    AppCategories.Fashion,
  ];

  void onCategoryChanged(String? selectedCategory) {
    emit(state.copyWith(selectedCategory: selectedCategory));
  }

  void removeFile(File file){
    if(isClosed)return;
    emit(state.copyWith(loadingState: LoadingState.init, message: '',pickedImages: List<File>.from(state.pickedImages)..remove(file)));
  }


  void selectImages() async {
    List<File> pickedImages = await imageFilePicker.pickImages() as List<File>;
    if(isClosed)return;
    emit(state.copyWith(pickedImages: pickedImages, showImgValidator: pickedImages.isEmpty));
  }

  Future<void> addProduct(String name, String description, double price,
      int quantity, String token) async {
    if(isClosed) return;
    if(state.pickedImages.isEmpty){
      emit(state.copyWith(showImgValidator: true));
      return;
    }
    if(isClosed) return;
    emit(state.copyWith(loadingState: LoadingState.loading, message: "",));
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
      if(isClosed) return;
      emit(state.copyWith(loadingState: LoadingState.error, message: l.message));
    }, (r) {
      if(isClosed) return;
      emit(state.copyWith(loadingState: LoadingState.loaded));
      sl<ProductsCubit>().addProduct(r.product);
    });
  }

}