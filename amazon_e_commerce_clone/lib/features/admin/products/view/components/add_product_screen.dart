import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/custom_textfiled.dart';
import 'package:amazon_e_commerce_clone/core/utils/general_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/global/components/reusable_components/primary_custom_elevatedbutton.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/utils/enums.dart';
import '../../viewmodels/add_products_cubit.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddProductsCubit>(),
      child: const AddProductView(),
    );
  }
}

class AddProductView extends StatefulWidget {
  const AddProductView({Key? key}) : super(key: key);

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  late final TextEditingController _productNameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;
  late final TextEditingController _quantityController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _productNameController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
    _quantityController = TextEditingController();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.appBarGradient,
          ),
        ),
        actions: [
          PopupMenuButton<MenuItem>(
            onSelected: (value) {
              switch (value) {
                case MenuItem.wishlists:
                  break;
                case MenuItem.logout:
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: MenuItem.wishlists,
                child: Row(
                  children: [
                    const Icon(Icons.shopping_bag_outlined),
                    const Spacer(),
                    Text(MenuItem.wishlists.name),
                  ],
                ),
              ),
              PopupMenuItem(
                value: MenuItem.logout,
                child: Row(
                  children: [
                    const Icon(Icons.logout_outlined),
                    const Spacer(),
                    Text(MenuItem.logout.name),
                  ],
                ),
              ),
            ],
          )
        ],
        centerTitle: true,
        title: const Text(
          "Add Product",
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
      body: BlocListener<AddProductsCubit, AddProductsState>(
        listener: (context, state) {
          switch(state.loadingState){
            case LoadingState.init:
            case LoadingState.loading:
            break;
            case LoadingState.loaded:
              context.showCustomSnackBar("Added Successfully", const Duration(seconds: 2));
              break;
            case LoadingState.error:
              context.showCustomSnackBar(state.message, const Duration(seconds: 2), Colors.red);
              break;
          }
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<AddProductsCubit, AddProductsState>(
                        buildWhen: (previous, current) =>
                            previous.pickedImages != current.pickedImages,
                        builder: (context, state) {
                          return Visibility(
                            visible: state.pickedImages.isNotEmpty,
                            replacement: GestureDetector(
                              onTap: AddProductsCubit.get(context).selectImages,
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(10),
                                dashPattern: const [10, 4],
                                strokeCap: StrokeCap.round,
                                child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.folder_open,
                                        size: 40,
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        "Select Product Images",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            child: CarouselSlider(
                              items: state.pickedImages
                                  .map((file) => Image.file(
                                        file,
                                        fit: BoxFit.cover,
                                        height: 200,
                                      ))
                                  .toList(),
                              options: CarouselOptions(
                                viewportFraction: 1,
                                enableInfiniteScroll: false,
                                animateToClosest: false,
                                height: 200,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      BlocBuilder<AddProductsCubit, AddProductsState>(
                        buildWhen: (previous, current) =>
                            previous.pickedImages != current.pickedImages ||
                            current.pickedImages.isEmpty,
                        builder: (context, state) {
                          return Visibility(
                              visible: state.showImgValidator,
                              replacement: const SizedBox(),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Select Images!",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ));
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        controller: _productNameController,
                        hintText: "Product Name",
                        validator: _productNameValidator,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: _descriptionController,
                        hintText: "Description",
                        validator: _descriptionValidator,
                        maxLines: 7,
                        textInputType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: _priceController,
                        hintText: "Price",
                        validator: _priceValidator,
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: _quantityController,
                        hintText: "Quantity",
                        validator: _quanityValidator,
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      BlocBuilder<AddProductsCubit, AddProductsState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: double.infinity,
                            child: DropdownButton<String>(
                              value: state.selectedCategory,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isExpanded: true,
                              items: AddProductsCubit.productCategories
                                  .map((item) {
                                return DropdownMenuItem(
                                    value: item, child: Text(item));
                              }).toList(),
                              onChanged: AddProductsCubit.get(context)
                                  .onCategoryChanged,
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: kMinInteractiveDimension,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: kMinInteractiveDimension,
                child: BlocBuilder<AddProductsCubit, AddProductsState>(
                  buildWhen: (previous, current) =>
                      current.loadingState != previous.loadingState,
                  builder: (context, state) {
                    switch (state.loadingState) {
                      case LoadingState.init:
                      case LoadingState.loaded:
                      case LoadingState.error:
                        return PrimaryCustomElevatedButton(
                          text: "Add",
                          onPressed: addProduct,
                        );
                      case LoadingState.loading:
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _productNameValidator(String? productName) {
    if(productName == null || productName.isEmpty){
      return "Enter valid product name";
    }
    if(productName.length<2){
      return "Product name cannot be less than 2";
    }
    return null;
  }

  String? _descriptionValidator(String? description) {
    if(description == null || description.isEmpty){
      return "Product Description cannot be empty";
    }
    if(description.length> 200){
      return "Product description cannot be bigger than 200 letters";
    }
    return null;
  }

  String? _priceValidator(String? price) {
    if(price == null || !RegExp(r"^\d+(\.\d+)?$").hasMatch(price)){
      return "Enter valid product price";
    }
    return null;
  }

  String? _quanityValidator(String? quantity) {
    if(quantity == null || !RegExp(r"^\d+(\.\d+)?$").hasMatch(quantity)){
      return "Enter valid product quantity";
    }
    return null;
  }

  void addProduct() {
    final AddProductsCubit addProductsCubitInstance =
        AddProductsCubit.get(context);
    if (_formKey.currentState!.validate()) {
      context.unFocusKeyboardFromScope();
      addProductsCubitInstance.addProduct(
        _productNameController.text,
        _descriptionController.text,
        double.parse(_priceController.text),
        double.parse(_quantityController.text),
        MainCubit.get(context).state.user.token,
      );
    }
  }
}
