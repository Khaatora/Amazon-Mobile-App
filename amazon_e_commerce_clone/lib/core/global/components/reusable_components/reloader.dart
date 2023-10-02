import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/primary_custom_elevatedbutton.dart';
import 'package:flutter/material.dart';

class ReloaderWidget extends StatelessWidget {
  const ReloaderWidget({super.key, required this.callBack});

  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Something went wrong",
                textAlign: TextAlign.center),
            PrimaryCustomElevatedButton(
              minimumWidth: 100,
              text: "Retry",
              onPressed: () => callBack(),
            )
          ],
        ));
  }
}
