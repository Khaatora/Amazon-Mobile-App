import 'package:amazon_e_commerce_clone/core/features/home/model/cart_product_model.dart';
import 'package:amazon_e_commerce_clone/core/features/home/model/product_model.dart';
import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/features/user/cart/view_models/cart_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/global/size_config.dart';
import '../../../../../core/services/services_locator.dart';

class CartProduct extends StatelessWidget {
  const CartProduct({super.key, required this.cartItem, this.enabled = true});

  final CartItem cartItem;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final Product product = cartItem.product;
    int quantity = cartItem.quantity;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: product.images[0],
                height: 130,
                width: SizeConfig.safeBlockHorizontal * 33,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "\$${product.price}",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "Eligible for FREE shipping",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      (product.quantity!=0 ? const Text(
                        "In Stock",
                        style: TextStyle(fontSize: 10, color: AppColors.teal),
                      ): const Text(
                        "Out of Stock!",
                        style: TextStyle(fontSize: 10, color: AppColors.red),
                      )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.black12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: quantity == 0
                          ? null
                          : () => sl<CartCubit>().removeFromCart(
                              MainCubit.get(context).state.user.token, product),
                      child: Container(
                        width: 36,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(Icons.remove),
                      ),
                    ),
                    Container(
                      width: 36,
                      height: 32,
                      color: AppColors.white,
                      alignment: Alignment.center,
                      child: Text(quantity.toString()),
                    ),
                    InkWell(
                      onTap: product.quantity == quantity
                          ? null
                          : () => sl<CartCubit>().addToCart(
                              MainCubit.get(context).state.user.token, product),
                      child: Container(
                        width: 36,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
