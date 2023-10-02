import 'package:amazon_e_commerce_clone/core/constants/app_routes.dart';
import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/loader.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/reloader.dart';
import 'package:amazon_e_commerce_clone/core/utils/general_utils.dart';
import 'package:amazon_e_commerce_clone/features/user/home/views/components/address_bar.dart';
import 'package:amazon_e_commerce_clone/features/user/search/view/components/reusable_components/searched_product_card.dart';
import 'package:amazon_e_commerce_clone/features/user/search/view_model/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/features/home/model/product_model.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/enums.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String query = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
        create: (context) => sl<SearchCubit>()
          ..initState(query, sl<MainCubit>().state.user.token),
        child: const SearchView());
  }
}

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String query = ModalRoute.of(context)!.settings.arguments as String;
    _searchController.value = TextEditingValue(
      text: query,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.appBarGradient,
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.mic),
              ),
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                      height: 42,
                      margin: const EdgeInsets.only(left: 16),
                      alignment: Alignment.topLeft,
                      child: Material(
                        borderRadius: BorderRadius.circular(7),
                        elevation: 1.0,
                        child: TextFormField(
                          textInputAction: TextInputAction.search,
                          controller: _searchController,
                          onFieldSubmitted: (query) {
                            SearchCubit.get(context).search(query, MainCubit.get(context).state.user.token);
                          },
                          decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {
                                SearchCubit.get(context).search(_searchController.text, MainCubit.get(context).state.user.token);
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Icon(
                                  Icons.search,
                                  color: AppColors.black,
                                  size: 24,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(top: 8),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide:
                                  BorderSide(color: Colors.black38, width: 1.0),
                            ),
                            hintText: "Search Amazon.in",
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          )),
      body: BlocConsumer<SearchCubit, SearchState>(
        listenWhen: (previous, current) =>
            current.loadingState != previous.loadingState,
        listener: (context, state) {
          if (state.loadingState == LoadingState.error) {
            context.showCustomSnackBar(
                state.message, const Duration(seconds: 2), AppColors.red);
          }
        },
        builder: (context, state) {
          switch (state.loadingState) {
            case LoadingState.init:
            case LoadingState.loading:
            case LoadingState.loaded:
              return state.products == null
                  ? const Loader()
                  : Column(
                      children: [
                        const AddressBar(),
                        const SizedBox(),
                        Expanded(
                            child: state.products!.isEmpty ? const Center(child: Text("There are no items matching that name"),):ListView.builder(
                              itemCount: state.products!.length,
                              itemBuilder: (context, index) {
                                final Product product = state.products![index];
                                return GestureDetector(
                                    onTap: () => product.quantity == 0 ? null:Navigator.pushNamed(
                                        context, AppRoutes.productDetailsScreen,
                                        arguments: product).then((value) => SearchCubit.get(context).refresh()),
                                    child: SearchedProductCard(product: product));
                              },
                            ))
                      ],
                    );
            case LoadingState.error:
              return ReloaderWidget(
                callBack: () => SearchCubit.get(context).initState(
                    state.query!, MainCubit.get(context).state.user.token),
              );
          }
        },
      ),
    );
  }
}
