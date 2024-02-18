import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {required this.onTap,
      required this.text,
      required this.textStyle,
      this.backgroundColor = Colors.white,
      this.borderColor = Colors.white,
      super.key});

  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback? onTap;
  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.grey.withAlpha(50)),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shadowColor: MaterialStateProperty.all(Colors.black),
        elevation: MaterialStateProperty.all(6),
        side: MaterialStateProperty.all(
          BorderSide(
            color: borderColor,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
