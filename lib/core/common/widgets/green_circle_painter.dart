import 'package:flutter/material.dart';
import 'package:junkpoint/core/theme/app_palette.dart';

class GreenCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path rectPath = Path();
    rectPath.addRect(Rect.fromLTRB(0, 0, width, height * 0.3));
    paint.color = AppPalette.mainColor;
    canvas.drawPath(rectPath, paint);

    Path arcPath = Path();
    arcPath.moveTo(-width * 0.3, height * 0.3);
    arcPath.quadraticBezierTo(
        width / 2, height / 2, width + width * 0.3, height * 0.3);
    canvas.drawPath(arcPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
