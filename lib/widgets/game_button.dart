import 'package:flutter/material.dart';

class GameButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color? textColor;
  final String text;
  const GameButton({
    this.textColor,
    required this.onPressed,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          )),
    );
  }
}
