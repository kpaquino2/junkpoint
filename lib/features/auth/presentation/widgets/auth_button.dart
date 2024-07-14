import 'package:flutter/material.dart';
import 'package:junkpoint/core/theme/app_palette.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const AuthButton(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(395, 55),
        backgroundColor: AppPalette.mainColor,
        foregroundColor: AppPalette.whiteColor,
      ),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class AppPallete {}
