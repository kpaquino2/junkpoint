import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:junkpoint/core/theme/app_palette.dart';

class AuthOtherButton extends StatelessWidget {
  final String provider;
  final IconData icon;
  final VoidCallback onPressed;
  const AuthOtherButton({
    super.key,
    required this.provider,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        fixedSize: const Size(320, 55),
        foregroundColor: AppPalette.mainColor,
        backgroundColor: AppPalette.whiteColor,
        side: const BorderSide(color: AppPalette.mainColor),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            FaIcon(icon),
            const SizedBox(width: 15),
            Text(
              "Continue with $provider",
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
