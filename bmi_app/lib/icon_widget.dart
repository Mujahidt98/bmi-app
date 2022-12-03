import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconWidget extends StatelessWidget {
  final String cardLabel;
  final IconData iconData;
  final double iconSize;

  IconWidget(
      {required this.cardLabel,
      required this.iconData,
      required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            icon: FaIcon(
              iconData,
              size: iconSize,
            ),
            onPressed: () {
              print("Pressed");
            }),
        SizedBox(height: 20),
        Text(cardLabel),
      ],
    );
  }
}
