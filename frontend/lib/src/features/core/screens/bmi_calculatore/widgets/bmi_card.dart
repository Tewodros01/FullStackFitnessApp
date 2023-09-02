import 'package:flutter/material.dart';

class BMICard extends StatelessWidget {
  const BMICard({
    super.key,
    this.color = Colors.white,
    this.child,
    this.onSelect,
    required this.heights,
    required this.widths,
  });
  final Color color;
  final Widget? child;
  final Function()? onSelect;
  final double heights;
  final double widths;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        height: heights,
        width: widths,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              blurRadius: 1,
            )
          ],
        ),
        child: child,
      ),
    );
  }
}
