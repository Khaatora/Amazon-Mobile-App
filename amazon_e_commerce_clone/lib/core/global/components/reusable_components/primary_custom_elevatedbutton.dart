import 'package:amazon_e_commerce_clone/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryCustomElevatedButton extends StatelessWidget {
  const PrimaryCustomElevatedButton({Key? key, this.onPressed, this.text = "Ok", this.minimumWidth = double.infinity, this.textStyle, this.backgroundColor, this.foregroundColor, this.enabled = true}) : super(key: key);

  final void Function()? onPressed;
  final String text;
  final double minimumWidth;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: enabled ? onPressed: null, style: ElevatedButton.styleFrom(
      minimumSize: Size(minimumWidth, kMinInteractiveDimension),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      disabledBackgroundColor: AppColors.greyBackgroundColor
    ), child: Text(text, style: textStyle),);
  }
}
