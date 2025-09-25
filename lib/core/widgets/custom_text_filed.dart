import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/app_colors.dart';

class CustomTextFiled extends StatelessWidget {
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
  final VoidCallback? onToggleVisibility;

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
    this.readOnly = false,
    this.obscureText = false,
    this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword ? obscureText : false,
      maxLines: maxLines ?? 1,
      controller: controller,
      validator: validator,
      readOnly: readOnly,
      style: const TextStyle(
        color: MColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: MColors.dgrey,
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
        hintText: hintText,
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
        prefix: prefix,
        prefixIcon: prefixIcon,
        suffixIcon: isPassword
            ? IconButton(
          onPressed: onToggleVisibility,
          icon: Icon(
            obscureText ? Icons.visibility_rounded : Icons.visibility_off_rounded,
            color: MColors.white,
          ),
        )
            : suffixIcon,
      ),
    );
  }
}
