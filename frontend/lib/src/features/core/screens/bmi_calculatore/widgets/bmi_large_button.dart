import 'package:flutter/material.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/constants/styles.dart';

class BMILargeButton extends StatelessWidget {
  const BMILargeButton({super.key, required this.text, required this.onTap});
  final Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: cSecondaryColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: cSecondaryColor,
              spreadRadius: 0,
              blurRadius: 4,
            )
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: cPrimaryColor),
          ),
        ),
      ),
    );
  }
}
