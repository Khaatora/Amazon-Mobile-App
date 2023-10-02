import 'dart:developer';

import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/loader.dart';
import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:amazon_e_commerce_clone/core/utils/general_utils.dart';
import 'package:amazon_e_commerce_clone/features/user/address/repository/i_address_repository.dart';
import 'package:amazon_e_commerce_clone/features/user/address/view_model/address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/global/components/reusable_components/custom_textfiled.dart';
import '../../../../core/services/services_locator.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double sum = ModalRoute.of(context)!.settings.arguments as double;
    return BlocProvider(
        create: (context) => AddressCubit(sl<IAddressRepository>())
          ..initState([
            PaymentItem(
                amount: sum.toString(),
                label: "Total Amount",
                status: PaymentItemStatus.final_price),
          ]),
        child: const AddressView());
  }
}

class AddressView extends StatefulWidget {
  const AddressView({super.key});

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  final TextEditingController _flatBuildingController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final GlobalKey<FormState> _addressFromKey = GlobalKey<FormState>();
  final Future<PaymentConfiguration> googlePaymentConfig =
      PaymentConfiguration.fromAsset("gpay.json");
  final Future<PaymentConfiguration> applePaymentConfig =
      PaymentConfiguration.fromAsset("applepay.json");

  @override
  void dispose() {
    super.dispose();
    _flatBuildingController.dispose();
    _areaController.dispose();
    _pinCodeController.dispose();
    _cityController.dispose();
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
          )),
      body: BlocConsumer<AddressCubit, AddressState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _addressFromKey,
                child: Column(
                  children: [
                    // CurrentAddressBar
                    BlocBuilder<MainCubit, MainState>(
                      buildWhen: (previous, current) =>
                          current.user.address != previous.user.address,
                      builder: (context, state) {
                        return Visibility(
                            visible: state.user.address.isNotEmpty,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.black12),
                                  ),
                                  width: double.infinity,
                                  child: Text(
                                    state.user.address,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Or",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ));
                      },
                    ),
                    // House no TextField
                    CustomTextField(
                      controller: _flatBuildingController,
                      validator: _flatBuildingValidator,
                      hintText: "Flat, House no, Building",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    //Area, Street TextField
                    CustomTextField(
                      controller: _areaController,
                      hintText: "Area, Street",
                      validator: _areaValidator,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // Pin Code TextField
                    CustomTextField(
                      controller: _pinCodeController,
                      validator: _pinCodeValidator,
                      hintText: "Pin Code",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // Town/City TextField
                    CustomTextField(
                      controller: _cityController,
                      validator: _cityValidator,
                      hintText: "Town/City",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    //Pay Button
                    FutureBuilder(
                      future: applePaymentConfig,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                          case ConnectionState.active:
                            return const Loader();
                          case ConnectionState.done:
                            return ApplePayButton(
                              width: double.infinity,
                              type: ApplePayButtonType.buy,
                              style: ApplePayButtonStyle.white,
                              paymentConfiguration: snapshot.data,
                              onPaymentResult: _onApplePayResult,
                              loadingIndicator: const Loader(),
                              paymentItems: state.paymentItems,
                              onPressed: () => onPayPress(
                                  MainCubit.get(context).state.user.address),
                              onError: (error) => AddressCubit.get(context)
                                  .showError(error.toString()),
                            );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    FutureBuilder(
                      future: googlePaymentConfig,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                          case ConnectionState.active:
                            return const Loader();
                          case ConnectionState.done:
                            return GooglePayButton(
                              width: double.infinity,
                              type: GooglePayButtonType.buy,
                              paymentConfiguration: snapshot.data,
                              onPaymentResult: _onGooglePayResult,
                              loadingIndicator: const Loader(),
                              paymentItems: state.paymentItems,
                              onPressed: () => onPayPress(
                                  MainCubit.get(context).state.user.address),
                              onError: (error) =>
                                  AddressCubit.get(context).showError(
                                error.toString(),
                              ),
                            );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listenWhen: (previous, current) =>
            current.loadingState == LoadingState.error ||
            current.loadingState == LoadingState.loaded,
        listener: (context, state) {
          log("rebuilding, ${state.loadingState.name}");
          if (state.loadingState == LoadingState.error) {
            context.showCustomSnackBar(
              state.message,
              const Duration(seconds: 2),
              AppColors.red,
            );
          } else if (state.loadingState == LoadingState.loaded) {
            context.showCustomSnackBar(
              "Your Purchase Is Successful!",
              const Duration(seconds: 2),
            );
          }
        },
      ),
    );
  }

  void _onGooglePayResult(Map<String, dynamic> result) {
    final mainCubit = MainCubit.get(context).state;
    final totalSum = ModalRoute.of(context)!.settings.arguments as double;
    AddressCubit.get(context).placeOrder(
      mainCubit.user.address,
      mainCubit.user.cart,
      totalSum,
      mainCubit.user.token,
    );
  }

  void _onApplePayResult(Map<String, dynamic> result) {
    final mainCubit = MainCubit.get(context).state;
    final totalSum = ModalRoute.of(context)!.settings.arguments as double;
    AddressCubit.get(context).placeOrder(
      mainCubit.user.address,
      mainCubit.user.cart,
      totalSum,
      mainCubit.user.token,
    );
  }

  void onPayPress(String address) {
    log(address);
    if (address.isEmpty) {
      if (_addressFromKey.currentState!.validate()) {
        address =
            "${_flatBuildingController.text}, ${_areaController.text}, ${_cityController.text} - ${_pinCodeController.text}";
        AddressCubit.get(context).startPaymentProcess(address);
        MainCubit.get(context).setAddress(address);
      } else {
        throw Exception("You need to enter an address");
      }
    } else {
      AddressCubit.get(context).startPaymentProcess(address);
    }
  }

  String? _flatBuildingValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Flat, House no, Building";
    }
    return null;
  }

  String? _areaValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Area, Street";
    }
    return null;
  }

  String? _pinCodeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Pin Code,";
    }
    return null;
  }

  String? _cityValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Town/City";
    }
    return null;
  }
}
