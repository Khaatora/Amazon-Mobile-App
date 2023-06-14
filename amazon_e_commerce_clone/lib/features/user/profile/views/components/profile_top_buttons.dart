import 'package:flutter/material.dart';

import 'reusable_components/profile_outlined_button.dart';

class ProfileTopButtons extends StatelessWidget {
  const ProfileTopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ProfileOutlinedButton(
              text: "Your Orders",
              onTap: () {},
            ),
            ProfileOutlinedButton(
              text: "Turn Seller",
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 8,),
        Row(
          children: [
            ProfileOutlinedButton(
              text: "Log Out",
              onTap: () {},
            ),
            ProfileOutlinedButton(
              text: "Your Wishlist",
              onTap: () {},
            ),
          ],
        )
      ],
    );
  }
}
