import 'package:flutter/material.dart';
import 'package:flutter_auth/styles/styles.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorText extends StatelessWidget {
  final String message;
  final bool isPortrait;
  final bool hasError;
  bool submitted;

  ErrorText({
    Key? key,
    required this.submitted,
    required this.message,
    required this.hasError,
    required this.isPortrait,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return submitted
      ? Text(
          message,
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              fontSize: 13,
              height: isPortrait ? 1.5 : 1.3,
              color: hasError ? AppColors.errorColor : AppColors.successColor,
            )
          ),
        )
      : const SizedBox.shrink();
  }
}
