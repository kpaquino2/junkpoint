import 'package:flutter/material.dart';
import 'package:junkpoint/core/theme/app_palette.dart';

class SquareButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final String desc;
  final VoidCallback onPressed;

  const SquareButton({
    super.key,
    required this.icon,
    this.label = "",
    this.desc = "",
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppPalette.greyColor),
          borderRadius: BorderRadius.circular(30)),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(160, 160),
          backgroundColor: AppPalette.transparentColor,
          shadowColor: AppPalette.transparentColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(
              label,
              style: TextStyle(
                  color: AppPalette.greyColor, fontWeight: FontWeight.bold),
            ),
            Text(
              desc,
              style: TextStyle(fontSize: 10, color: AppPalette.greyColor),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
