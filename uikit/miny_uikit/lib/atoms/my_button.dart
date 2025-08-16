import 'package:flutter/material.dart';

enum ButtonState { primary, secondary, disabled }

class MyButton extends StatelessWidget {
  const MyButton({
    required this.label,
    required this.onPressed,
    required this.buttonState,
    super.key,
  });
  final String label;
  final VoidCallback onPressed;
  final ButtonState buttonState;

  @override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor:
          buttonState == ButtonState.primary
              ? Colors.red
              : buttonState == ButtonState.secondary
              ? Colors.amber
              : Colors.grey,
    ),
    child: Text(label),
  );
}
