import 'dart:developer';

import 'package:amazon_e_commerce_clone/core/features/home/model/order_model.dart';
import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/loader.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/primary_custom_elevatedbutton.dart';
import 'package:amazon_e_commerce_clone/core/global/size_config.dart';
import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:amazon_e_commerce_clone/features/admin/orders/viewmodels/orders_cubit.dart';
import 'package:amazon_e_commerce_clone/features/order_details/view/components/product_details.dart';
import 'package:amazon_e_commerce_clone/features/order_details/view_model/order_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/services/services_locator.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Order order = ModalRoute.of(context)!.settings.arguments as Order;
    return BlocProvider(
        create: (context) => sl<OrderDetailsCubit>()..initState(order),
        child: const OrderDetailsView());
  }
}

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final Order order = ModalRoute.of(context)!.settings.arguments as Order;
    final user = MainCubit.get(context).state.user;
    const SizeConfig().init(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.appBarGradient,
              ),
            ),
            title: Text(
              "order contains ${order.items.length} item(s)",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          width: SizeConfig.safeScreenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Order Details:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: AppColors.black12,
                )),
                child: Table(
                  columnWidths: const {
                    1: FlexColumnWidth(1.2),
                  },
                  children: [
                    TableRow(children: [
                      const TableCell(
                        child: Text("Date: "),
                      ),
                      TableCell(
                          child: Text(DateFormat().format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  order.orderedAt))))
                    ]),
                    TableRow(children: [
                      const TableCell(
                        child: Text("ID: "),
                      ),
                      TableCell(child: Text(order.id))
                    ]),
                    TableRow(children: [
                      const TableCell(
                        child: Text("Total Price: "),
                      ),
                      TableCell(
                          child: Text("\$${order.totalPrice.toString()}"))
                    ]),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Items Details:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: AppColors.black12,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...order.items
                        .map((item) => OrdersProductDetails(
                            product: item.product, quantity: item.quantity))
                        .toList()
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Order Status:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: SizeConfig.safeScreenHeight*0.7,
                ),
                child: BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
                  buildWhen: (previous, current) =>
                      current.changeOrderStatusLoadingState ==
                      LoadingState.loaded,
                  listenWhen: (previous, current) =>
                  current.changeOrderStatusLoadingState ==
                      LoadingState.loaded,
                  listener: (subContext, state) {
                    if(state.changeOrderStatusLoadingState == LoadingState.loaded){
                      sl<OrdersCubit>().updateOrders(state.order!);
                    }
                  },
                  builder: (context, state) {
                    final isUser = user.type == UserType.user.name;
                    log("${state.order?.status ?? "null"}");
                    return state.order == null ? const Loader() : Stepper(
                        currentStep: state.order!.status,
                        controlsBuilder: (context, details) {
                          if (user.type == UserType.admin.name && details.currentStep < 3) {
                            return PrimaryCustomElevatedButton(
                              text: 'Done',
                              onPressed: () {
                                OrderDetailsCubit.get(context)
                                    .updateOrderStatus(
                                  details.currentStep,
                                  state.order!.id,
                                  user.token,
                                );
                              },
                            );
                          } else {
                            return const SizedBox(width: double.infinity,);
                          }
                        },
                        steps: <Step>[
                          Step(
                              state: state.order!.status > 0
                                  ? StepState.complete
                                  : StepState.indexed,
                              isActive: state.order!.status >= 0,
                              title: const Text("Delivering"),
                              content: Text(
                                  "${isUser ? "Your order" : "Order"} is yet to be delivered")),
                          Step(
                              state: state.order!.status > 1
                                  ? StepState.complete
                                  : StepState.indexed,
                              isActive: state.order!.status >= 1,
                              title: const Text("Awaiting Sign"),
                              content: Text(
                                  "${isUser ? "Your order" : "Order"} has been delivered, ${isUser ? "you are yet to sign" : "it has not been signed yet"}")),
                          Step(
                              state: state.order!.status > 2
                                  ? StepState.complete
                                  : StepState.indexed,
                              isActive: state.order!.status >= 2,
                              title: const Text("Signed"),
                              content: Text(
                                  "${user.type == UserType.user.name ? "Your order" : "Order"} has been delivered and signed ${isUser ? "by you" : ""}!")),
                          Step(
                              state: state.order!.status == 3
                                  ? StepState.complete
                                  : StepState.indexed,
                              isActive: state.order!.status == 3,
                              title: const Text("Completed"),
                              content: const SizedBox()
                              //Text("${isUser ? "Your order" : "Order"} order is yet to be delivered"),
                              ),
                        ],);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
