import 'dart:developer';

import 'package:amazon_e_commerce_clone/core/constants/app_colors.dart';
import 'package:amazon_e_commerce_clone/core/constants/app_routes.dart';
import 'package:amazon_e_commerce_clone/core/reusable_components/custom_textfiled.dart';
import 'package:amazon_e_commerce_clone/core/reusable_components/primary_custom_elevatedbutton.dart';
import 'package:amazon_e_commerce_clone/core/utils/general_utils.dart';
import 'package:amazon_e_commerce_clone/features/auth/view_models/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/enums.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => sl<AuthCubit>(),
      child: const AuthView(),
    );
  }
}

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _signinFormKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          minimum: const EdgeInsets.all(8.0),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  switch (state.loadingState) {
                    case LoadingState.init:
                      break;
                    case LoadingState.loading:
                      switch (state.authType) {
                        case Auth.signin:
                          context.showCustomSnackBar(
                              "signing in, please wait...",
                              const Duration(seconds: 1, milliseconds: 500));
                          break;
                        case Auth.signup:
                          context.showCustomSnackBar(
                              "Creating your account, please wait...",
                              const Duration(seconds: 1, milliseconds: 500));
                          break;
                      }
                      break;
                    case LoadingState.loaded:
                      context.showCustomSnackBar("Done!",
                          const Duration(seconds: 1, milliseconds: 500));
                      switch (state.authType) {
                        case Auth.signin:
                          Navigator.pushNamedAndRemoveUntil(
                              context, AppRoutes.homeScreen, (route) => false);
                          break;
                        case Auth.signup:
                          break;
                      }
                      break;
                    case LoadingState.error:
                      context.showCustomSnackBar(
                          state.message,
                          const Duration(
                            seconds: 1,
                            milliseconds: 500,
                          ),
                          Colors.red);
                      break;
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    ListTile(
                      tileColor: state.authType == Auth.signup
                          ? AppColors.backgroundColor
                          : AppColors.greyBackgroundCOlor,
                      title: const Text(
                        'Create Account',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Radio(
                        value: Auth.signup,
                        groupValue: state.authType,
                        onChanged: (Auth? value) {
                          if (value != null) {
                            AuthCubit.get(context).setAuthType(value);
                          }
                        },
                        activeColor: AppColors.secondaryColor,
                      ),
                    ),
                    ListTile(
                      tileColor: state.authType == Auth.signin
                          ? AppColors.backgroundColor
                          : AppColors.greyBackgroundCOlor,
                      title: const Text(
                        'Sign In',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Radio(
                        value: Auth.signin,
                        groupValue: state.authType,
                        onChanged: (Auth? value) {
                          if (value != null) {
                            AuthCubit.get(context).setAuthType(value);
                          }
                        },
                        activeColor: AppColors.secondaryColor,
                      ),
                    ),
                    Expanded(
                      child: Visibility(
                          visible: (state.authType == Auth.signup),
                          replacement: Center(
                            child: SingleChildScrollView(
                              child: Form(
                                key: _signinFormKey,
                                child: Column(
                                  children: [
                                    // E-mail TextField
                                    CustomTextField(
                                        controller: _emailController,
                                        hintText: "Email",
                                        validator: _emailValidator),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    //Password TextField
                                    CustomTextField(
                                        controller: _passwordController,
                                        hintText: "Password",
                                        autocorrect: false,
                                        enableSuggestions: false,
                                        obscureText: true,
                                        validator: _passwordValidator),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      height: kMinInteractiveDimension,
                                      child: BlocBuilder<AuthCubit, AuthState>(
                                        builder: (context, state) {
                                          switch (state.loadingState) {
                                            case LoadingState.init:
                                            case LoadingState.error:
                                            case LoadingState.loaded:
                                              return PrimaryCustomElevatedButton(
                                                onPressed: _signIn,
                                                text: "Sign In",
                                              );
                                            case LoadingState.loading:
                                              return const Center(
                                                child: CircularProgressIndicator
                                                    .adaptive(),
                                              );
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Form(
                                key: _signupFormKey,
                                child: Column(
                                  children: [
                                    //Name TextField
                                    CustomTextField(
                                        controller: _nameController,
                                        hintText: "Name",
                                        validator: _nameValidator),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    //E-mail TextField
                                    CustomTextField(
                                        controller: _emailController,
                                        hintText: "Email",
                                        validator: _emailValidator),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    //Password TextField
                                    CustomTextField(
                                        controller: _passwordController,
                                        hintText: "Password",
                                        autocorrect: false,
                                        enableSuggestions: false,
                                        obscureText: true,
                                        validator: _passwordValidator),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      height: kMinInteractiveDimension,
                                      child: BlocBuilder<AuthCubit, AuthState>(
                                        builder: (context, state) {
                                          switch (state.loadingState) {
                                            case LoadingState.init:
                                            case LoadingState.error:
                                            case LoadingState.loaded:
                                              return PrimaryCustomElevatedButton(
                                                onPressed: _signUp,
                                                text: "Sign Up",
                                              );
                                            case LoadingState.loading:
                                              return const Center(
                                                child: CircularProgressIndicator
                                                    .adaptive(),
                                              );
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }

  //TODO: s
  String? _nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return "Please Enter Valid Name";
    }
    return null;
  }

  String? _emailValidator(String? email) {
    if (email == null ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email)) {
      return "Please Enter Valid Name";
    }
    return null;
  }

  String? _passwordValidator(String? password) {
    if (password == null || password.length < 6) {
      return "Please Enter Valid Password";
    }
    return null;
  }

  void _signUp() {
    if (_signupFormKey.currentState!.validate()) {
      log("validated");
      AuthCubit.get(context).signup(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  void _signIn() {
    if (_signinFormKey.currentState!.validate()) {
      log("validated");
      AuthCubit.get(context).login(
        _emailController.text,
        _passwordController.text,
      );
    }
  }
}
