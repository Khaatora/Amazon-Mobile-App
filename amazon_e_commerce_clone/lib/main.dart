import 'dart:developer';

import 'package:amazon_e_commerce_clone/core/constants/app_routes.dart';
import 'package:amazon_e_commerce_clone/core/global/app_theme.dart';
import 'package:amazon_e_commerce_clone/core/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/services/services_locator.dart';
import 'package:amazon_e_commerce_clone/core/utils/general_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/enums.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServicesLocator().init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<MainCubit>(
      create: (context) => sl<MainCubit>(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      buildWhen: (previous, current) => current.loadingState != previous.loadingState,
      listener: (context, state) {
        log(state.message);
        context.showCustomSnackBar(
          state.message,
          const Duration(seconds: 2),
          Colors.red,
        );
      },
      builder: (context, state) {
        return MaterialApp(
          title: 'E-Commerce App',
          theme: AppTheme.light,
          initialRoute: state.loadingState == LoadingState.loaded
              ? AppRoutes.homeScreen
              : AppRoutes.authScreen,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (routeSettings) =>
              AppRoutes.generateRoute(routeSettings),
        );
      },
    );
  }
}
