import 'package:flutter/material.dart';
import 'package:junkpoint/core/common/widgets/green_circle_painter.dart';
import 'package:junkpoint/core/theme/app_palette.dart';

class LogInPage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LogInPage(),
      );

  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: GreenCirclePainter(),
        child: const Center(
          child: Column(
            children: [
              SizedBox(height: 75),
              Text(
                "JUNKPOINT",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppPalette.whiteColor),
              ),
              Icon(
                Icons.person,
                color: AppPalette.whiteColor,
                size: 280,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
