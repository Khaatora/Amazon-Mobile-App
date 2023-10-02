import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      buildWhen: (previous, current) => current.user != previous.user,
      builder: (context, state) {
        double sum = state.user.cart.fold(0, (previousValue, item) {
          return previousValue+=(item.quantity * item.product.price );
        });
        return Container(
          margin: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text("SubTotal ", style: Theme.of(context).textTheme.titleMedium,),
              Text("\$$sum", style: Theme.of(context).textTheme.titleLarge,)
            ],
          ),
        );
      },
    );
  }
}
