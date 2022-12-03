import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Color newColor;
  final Widget cardChild;

  ReusableCard({required this.newColor, required this.cardChild});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: cardChild,
      decoration: BoxDecoration(
        color: newColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.all(15),
    );
  }
}
