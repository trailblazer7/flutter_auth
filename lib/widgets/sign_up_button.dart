import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignUpButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientElevatedButton(
      onPressed: onPressed,
      style: GradientElevatedButton.styleFrom(
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(112, 194, 255, 1),
          Color.fromRGBO(80, 112, 255, 1),
        ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Text(
        'Sign up',
        style: GoogleFonts.inter(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.white,
        )
        ),
      )
    );
  }
}
