import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.style,
    required this.controller,
    this.decoration,
    required this.hintText,
    this.validator,
    this.textInputType,
    this.textInputAction,
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.readOnly = false,
    this.minLines,
    this.maxLines = 1,
  }) : super(key: key);

  final TextStyle? style;
  final TextEditingController controller;
  final InputDecoration? decoration;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool readOnly;
  final int? minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style,
      controller: controller,
      decoration: decoration ??
           InputDecoration(
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black38)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black38)),
            hintText: hintText,
          ),
      validator: validator,
      keyboardType: textInputType ?? TextInputType.name,
      textInputAction: textInputAction,
      obscureText: obscureText,
      autocorrect: autocorrect,
      minLines: minLines,
      maxLines: maxLines,
      enableSuggestions: enableSuggestions,
      readOnly: readOnly,
    );
  }
}
