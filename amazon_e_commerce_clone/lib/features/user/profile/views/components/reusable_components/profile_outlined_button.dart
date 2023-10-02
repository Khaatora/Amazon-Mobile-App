import 'package:amazon_e_commerce_clone/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileOutlinedButton extends StatelessWidget {
  const ProfileOutlinedButton({required this.text, required this.onTap, Key? key}) : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0.0),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.black.withOpacity(0.03),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
