import 'package:amazon_e_commerce_clone/core/constants/app_colors.dart';
import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:flutter/material.dart';

class ProfileGreeting extends StatelessWidget {
  const ProfileGreeting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.appBarGradient,
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          RichText(text:  TextSpan(
            text: "Hello, ",
            style: const TextStyle(
              fontSize: 22,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                  text: MainCubit.get(context).state.user.name,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w600
                  ),
              )
            ]
          )),
        ],
      ),
    );
  }
}
