import 'package:flutter/material.dart';

class PrimaryCustomElevatedButton extends StatelessWidget {
  const PrimaryCustomElevatedButton({Key? key, this.onPressed, this.text = "Ok", this.minimumWidth = double.infinity, this.textStyle}) : super(key: key);

  final void Function()? onPressed;
  final String text;
  final double minimumWidth;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, style: ElevatedButton.styleFrom(
      minimumSize: Size(minimumWidth, kMinInteractiveDimension),
    ), child: Text(text, style: textStyle),);
  }
}
