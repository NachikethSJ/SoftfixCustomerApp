
import 'package:flutter/material.dart';
import 'package:salon_customer_app/styles/app_colors.dart';



class CustomTextField extends StatefulWidget {
  CustomTextField({
    this.onTap,
    this.password = false,
    required this.controller,
    this.hintText = '',
    this.labelText = '',
    this.readOnly = false,
    this.visibleIcon = true,
    this.maxLength,
    this.maxLines,
    this.expands = false,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    this.onChanged,
    this.suffixIcon,
    this.preffixIcon,
    this.isSuffixIconVisible = false,
    this.suffixText = '',
    this.isSuffixText = false,
    Key? key,
    this.validator,
    this.errorStyle,
    this.color,
  }) : super(key: key);

  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final void Function()? onTap ;
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool readOnly;
  final bool obscureText;
  final bool visibleIcon;
  final TextInputType inputType;
  final int? maxLength;
  final int? maxLines;
  final bool? password;
  final Color? color;
  final bool expands;
  final TextStyle? errorStyle;
  IconData? suffixIcon;
  IconData? preffixIcon;
  bool isSuffixIconVisible;
  String? suffixText;
  bool isSuffixText;


  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  get labelText => widget.labelText;
  get hintText => widget.hintText;
  get controller => widget.controller;
  get validatorFunc => widget.validator;
  get onChanged => widget.onChanged;
  get readOnly => widget.readOnly;
  get obscureText => widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        // color: Colors.white,
        color: Colors.white,
        // border: Border.all(color: Colors.grey)
      ),
      child: TextFormField(
        inputFormatters: [],
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
          fontFamily: 'RethinkSans',
          // color: Theme.of(context).textTheme.bodyLarge!.color,
          color: Colors.black,
        ),
        validator: widget.validator,
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.top,
        expands: widget.expands,
        keyboardType: widget.inputType,
        controller: widget.controller,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        readOnly: widget.readOnly,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appColors.appColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appColors.appColor)),
          suffixIconConstraints:
          const BoxConstraints(maxHeight: 30, maxWidth: 30),
          suffixIcon: Visibility(
            visible: widget.isSuffixIconVisible,
            child: Container(
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // color: ColorConstants.green.withOpacity(.7),
              ),
              child: Center(
                child: Icon(
                  widget.suffixIcon,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          errorStyle: const TextStyle(color: Colors.white),
          isDense: true,
          labelStyle: const TextStyle(color: Colors.black),
          errorMaxLines: 3,
          hintText: widget.hintText,
          counterText: '',
          hintStyle: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.6)),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
