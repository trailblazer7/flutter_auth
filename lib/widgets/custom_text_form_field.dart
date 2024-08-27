import 'package:flutter/material.dart';
import 'package:flutter_auth/styles/styles.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final void Function(String)? onChanged;
  bool submitted;
  bool hasError;
  String hintText;
  IconButton? suffixIcon;
  bool obscureText = false;

  CustomTextFormField({
    Key? key,
    required this.onChanged, 
    required this.submitted, 
    required this.hasError,
    required this.hintText,
    this.suffixIcon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.inter(
        textStyle: TextStyle(
          fontSize: 16,
          color: submitted ? (hasError ? AppColors.errorColor : AppColors.successColor) : const Color.fromRGBO(21, 29, 81, 1),
        )
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 13, bottom: 13),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          textStyle: const TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(111, 145, 188, 1)
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: submitted ? (hasError ? AppColors.errorColor : AppColors.successColor) : Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: submitted ? (hasError ? AppColors.errorColor : AppColors.successColor) : const Color.fromRGBO(111, 145, 188, 1),
          ),
        ),
        suffixIcon: suffixIcon
      ),
      obscureText: obscureText,
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
    );
  }
}
