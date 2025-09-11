import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/app_colors.dart';


class CustomTextFiled extends StatefulWidget {
  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool isPassword;
  final int? maxLines;
  final bool readOnly;
  final bool obscureText;


  const CustomTextFiled({
    super.key,
    this.prefix,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.hintText,
    this.validator,
    this.maxLines,
    this.isPassword = false,
    this.readOnly =false,
    this.obscureText = false,


  });

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword ? isShow : false,
      maxLines: widget.maxLines ?? 1,
      controller: widget.controller,
      validator: widget.validator,
      readOnly: widget.readOnly,
      style: const TextStyle(
        color: MColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: MColors.dgrey,
        hintStyle: TextStyle(
          color: Colors.white , fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
        hintText: widget.hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: MColors.dgrey),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: MColors.yellow, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: MColors.dgrey),
          borderRadius: BorderRadius.circular(16),
        ),
        prefix: widget.prefix,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
          onPressed: () {
            setState(() {
              isShow = !isShow;
            });
          },
          icon: Icon(
            isShow
                ? Icons.visibility_rounded
                : Icons.visibility_off_rounded,
            color: MColors.white,
          ),
        )
            : widget.suffixIcon,
      ),
    );
  }

}
