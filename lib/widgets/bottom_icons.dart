import 'package:flutter/material.dart';

class BottomIcons extends StatelessWidget {
  const BottomIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'images/star.png',
              height: 27,
              width: 27,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              'images/star.png',
              height: 20,
              width: 20,
            ),
          ),
        ],
      ),
    );
  }
}