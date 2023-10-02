
import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/primary_custom_elevatedbutton.dart';
import 'package:amazon_e_commerce_clone/core/global/size_config.dart';
import 'package:amazon_e_commerce_clone/features/user/cart/view_models/cart_cubit.dart';
import 'package:amazon_e_commerce_clone/features/user/cart/views/components/cart_product.dart';
import 'package:amazon_e_commerce_clone/features/user/cart/views/components/cart_subtotal.dart';
import 'package:amazon_e_commerce_clone/features/user/home/views/components/address_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/services/services_locator.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<CartCubit>(), child: const CartView());
  }
}

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late final TextEditingController _searchController;

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
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                          onFieldSubmitted: _navigateToSearchScreen,
                          decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {
                                _navigateToSearchScreen(_searchController.text);
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
                              fontSize: 17,
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: SizedBox(
          height: SizeConfig.safeBlockVertical * 100,
          child: Column(
            children: [
              const AddressBar(),
              const CartSubtotal(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: BlocBuilder<MainCubit, MainState>(
                  buildWhen: (previous, current) =>
                      current.user != previous.user,
                  builder: (context, state) {
                    return PrimaryCustomElevatedButton(
                      text: "Proceed To Buy (${state.user.cart.length}) items",
                      backgroundColor: AppColors.secondaryColor2,
                      foregroundColor: AppColors.black,
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      onPressed: state.user.cart.isEmpty
                          ? null
                          : () => _navigateToAddressScreen<double>(state
                                  .user.cart
                                  .fold(0, (previousValue, item) {
                                return previousValue +=
                                    (item.quantity * item.product.price);
                              })),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                color: AppColors.black12.withOpacity(0.08),
                height: 1,
              ),
              const SizedBox(
                height: 8,
              ),
              BlocBuilder<MainCubit, MainState>(
                buildWhen: (previous, current) =>
                    current.user.cart != previous.user.cart,
                builder: (context, state) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.user.cart.length,
                      itemBuilder: (context, index) {
                        return CartProduct(cartItem: state.user.cart[index]);
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToSearchScreen(String query) {
    if (query.isNotEmpty) {
      Navigator.pushNamed(context, AppRoutes.searchScreen, arguments: query);
    }
  }

  void _navigateToAddressScreen<T>(T arguments) {
    Navigator.pushNamed(context, AppRoutes.addressScreen, arguments: arguments);
  }
}
