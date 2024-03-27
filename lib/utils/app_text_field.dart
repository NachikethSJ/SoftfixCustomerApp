import 'package:flutter/material.dart';
import 'package:salon_customer_app/styles/app_colors.dart';

class AppTextField extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? iconData;
  final Widget? leadingIcon;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final bool readOnly;
  final Color? borderColor;
  final TextEditingController? controller;
  final Function()? onTap;
  final String? hintText;
  final void Function(String value)? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool obscureText;
  final FocusNode? focusNode;
  final int? maxLength;
  final int? maxLines;
  final String? suffixText;
  final String? counterText;
  final double? fontSize;
  final Widget? prefixIcon;
  final TextInputType? keyBoardType;
  final bool? enabled;
  final void Function(String)? onFieldSubmitted;
  final EdgeInsetsGeometry contentPadding;
  final String obscuringCharacter;
  final TextAlign textAlign;
  final String? prefixText;
  final TextStyle? hintStyle;
  final bool? filled;
  const AppTextField({
    super.key,
    this.labelText,
    this.width = 1,
    this.filled,
    this.iconData,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.height,
    this.hintText,
    this.onChanged,
    this.hintStyle,
    this.prefixIcon,
    this.leadingIcon,
    this.initialValue,
    this.style = const TextStyle(),
    this.validator,
    this.fontSize = 14,
    this.obscureText = false,
    this.focusNode,
    this.keyBoardType,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.borderColor,
    this.labelStyle,
    this.maxLength,
    this.prefixText,
    this.counterText,
    this.obscuringCharacter = '•',
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
    this.suffixText,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      width: w * width!,
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        enabled: enabled,
        focusNode: focusNode,
        initialValue: initialValue,
        validator: validator,
        onChanged: onChanged,
        readOnly: readOnly,
        obscureText: obscureText,
        onTap: onTap,
        textAlign: textAlign,
        keyboardType: keyBoardType,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: maxLength,
        maxLines: maxLines,
        enableSuggestions: true,
        style: TextStyle(
          fontSize: fontSize,
        ),
        obscuringCharacter: obscuringCharacter,
        decoration: InputDecoration(
          fillColor: appColors.appGray100,
          prefixIcon: prefixIcon,
          counterText: '',
          prefix: leadingIcon,
          prefixText: prefixText,
          suffixText: suffixText,
          filled: filled ?? readOnly,
          hintText: hintText,
          hintStyle: hintStyle,
          suffixIcon: iconData,
          labelText: labelText == '' ? null : labelText,
          contentPadding: contentPadding,
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
