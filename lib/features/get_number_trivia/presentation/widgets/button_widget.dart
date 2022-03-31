import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final Color buttonColor;
  final void Function() onPressed;

  const CustomButton(
      {Key? key,
      required this.buttonName,
      required this.buttonColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(buttonName),
      color: buttonColor,
      textTheme: ButtonTextTheme.primary,
      onPressed: onPressed,
    );
  }
}
