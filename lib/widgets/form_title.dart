import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormTitle extends StatelessWidget {
  final String title;

  const FormTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 230,
        height: 70,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 19,
              left: 40,
              child: Image.asset(
                'images/star.png',
                height: 17,
                width: 17,
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset(
                'images/star.png',
                height: 25,
                width: 25,
              ),
            ),
            Center(
              child: Text(
                'Sign up',
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Color.fromRGBO(74, 78, 113, 1),
                )
                ),
              ),
              
            ),
          ],
        )
      ),
    );
  }
}
