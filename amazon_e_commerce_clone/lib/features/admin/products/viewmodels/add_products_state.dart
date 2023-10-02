part of 'add_products_cubit.dart';

class AddProductsState extends Equatable {
  final String selectedCategory;
  final LoadingState loadingState;
  final List<File> pickedImages;

  final bool showImgValidator;

  final String message;

  const AddProductsState({
    this.selectedCategory = AppCategories.Mobiles,
    this.loadingState = LoadingState.init,
    this.pickedImages = const [],
    this.message = '',
    this.showImgValidator = false,
  });

  AddProductsState copyWith({
    String? selectedCategory,
    LoadingState? loadingState,
    List<File>? pickedImages,
    String? message,
    bool? showImgValidator,
  }) {
    return AddProductsState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      loadingState: loadingState ?? this.loadingState,
      pickedImages: pickedImages ?? this.pickedImages,
      showImgValidator: showImgValidator ?? this.showImgValidator,
      message: message ?? this.message,
    );
  }

  @override
  List get props => [
        selectedCategory,
        loadingState,
        pickedImages,
        showImgValidator,
      ];
}
