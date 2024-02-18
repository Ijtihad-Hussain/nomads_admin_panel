
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Color? color;
  final double? height;
  final double? width;
  final bool? isTextAlignCenter;
  final bool? isLoading;
  final bool obscureText;
  final InputBorder? border;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final Widget? prefix;
  final int? maxLines;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    Key? key,
    this.keyboardType,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.color,
    this.height,
    this.width,
    this.isTextAlignCenter = false,
    this.isLoading = false,
    this.obscureText = false,
    this.border,
    this.controller,
    this.validate,
    this.prefix,
    this.maxLines,
    this.focusNode,
    this.textInputAction,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 16.w,
      width: width ?? 30.w,
      margin: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextFormField(
        controller: controller,
        validator: validate,
        onChanged: onChanged,
        textAlign: isTextAlignCenter == true ? TextAlign.center : TextAlign.left,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: obscureText,
        cursorColor: kYellow,
        decoration: InputDecoration(
          hintText: hintText,
          prefix: prefix,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          border: border ?? InputBorder.none,
        ),
      ),
    );
  }
}

