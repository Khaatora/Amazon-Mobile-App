import 'dart:developer';

import 'package:amazon_e_commerce_clone/core/constants/app_routes.dart';
import 'package:amazon_e_commerce_clone/core/global/app_theme.dart';
import 'package:amazon_e_commerce_clone/core/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/features/main/view_model/main_cubit.dart';
import 'core/utils/enums.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await const ServicesLocator().init();
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
        log("Main class >>>>>>>>>>>>>>${state.message}<<<<<<<<<<<<<");
      },
      builder: (context, state) {
        log(state.user.type);
        return MaterialApp(
          title: 'E-Commerce App',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.light,
          initialRoute: state.loadingState == LoadingState.loaded && state.user.token.isNotEmpty
              ? (state.user.type == UserType.user.name ? AppRoutes.userScreen : AppRoutes.adminScreen)
              : AppRoutes.authScreen,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (routeSettings) =>
              AppRoutes.generateRoute(routeSettings),
        );
      },
    );
  }
}
