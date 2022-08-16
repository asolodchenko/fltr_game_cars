import 'package:flutter/material.dart';

class PauseButton extends StatelessWidget {
  final void Function()? onPressed;

  static const String id = 'PauseButton';

  const PauseButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: const Icon(Icons.pause_circle_outlined, size: 32),
        onPressed: onPressed,
      ),
    );
  }
}
