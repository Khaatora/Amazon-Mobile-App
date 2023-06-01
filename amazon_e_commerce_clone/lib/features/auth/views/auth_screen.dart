import 'package:amazon_e_commerce_clone/core/constants/app_colors.dart';
import 'package:amazon_e_commerce_clone/core/reusable_components/custom_textfiled.dart';
import 'package:amazon_e_commerce_clone/core/reusable_components/primary_custom_elevatedbutton.dart';
import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:amazon_e_commerce_clone/features/auth/view_models/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';

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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                                      controller: _emailController,
                                      hintText: "Password",
                                      autocorrect: false,
                                      enableSuggestions: false,
                                      obscureText: true,
                                      validator: _passwordValidator),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  PrimaryCustomElevatedButton(
                                    onPressed: _signIn,
                                    text: "Sign In",
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
                                  PrimaryCustomElevatedButton(
                                    onPressed: _signUp,
                                    text: "Sign Up",
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
              );
            },
          )),
    );
  }
  //TODO: s
  String? _nameValidator(String? name) {}

  String? _emailValidator(String? email) {}

  String? _passwordValidator(String? password) {}

  void _signUp() {

  }

  void _signIn() {

  }
}
