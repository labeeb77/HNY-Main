import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final TextInputAction textInputAction;
  final VoidCallback? onFieldSubmitted;
  final Color? borderColor;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    this.borderColor,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        validator: validator,
        onFieldSubmitted: (_) => onFieldSubmitted?.call(),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          enabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(color:borderColor!=null?borderColor!: AppColors.primary)),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFFFFF)),
            borderRadius: BorderRadius.circular(4),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFFFFF)),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder:  OutlineInputBorder(
              borderSide: BorderSide(color:borderColor!=null?borderColor!: AppColors.primary)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
