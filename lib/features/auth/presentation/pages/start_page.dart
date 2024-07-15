import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:junkpoint/core/common/widgets/green_circle_painter.dart';
import 'package:junkpoint/core/common/widgets/square_button.dart';
import 'package:junkpoint/core/theme/app_palette.dart';
import 'package:junkpoint/features/auth/presentation/pages/client_signup_page.dart';
import 'package:junkpoint/features/auth/presentation/pages/login_page.dart';
import 'package:junkpoint/features/auth/presentation/pages/shop_signup_page.dart';

// TODO verify email
// TODO sign up using other platforms

class StartPage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const StartPage(),
      );
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: GreenCirclePainter(),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 65),
              const Text(
                "JUNKPOINT",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppPalette.whiteColor),
              ),
              const Icon(
                Icons.person,
                color: AppPalette.whiteColor,
                size: 250,
              ),
              const Text(
                "What will you be using JunkPoint for?",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareButton(
                    icon: const Icon(
                      Icons.groups,
                      color: AppPalette.mainColor,
                      size: 100,
                    ),
                    label: "Client",
                    desc: "You're here to sell recyclables",
                    onPressed: () {
                      Navigator.push(context, ClientSignUpPage.route());
                    },
                  ),
                  const SizedBox(width: 30),
                  SquareButton(
                    icon: const Icon(
                      Icons.local_shipping,
                      color: AppPalette.mainColor,
                      size: 100,
                    ),
                    label: "Junk Shop",
                    desc: "You're here to collect recyclables",
                    onPressed: () {
                      Navigator.push(context, ShopSignUpPage.route());
                    },
                  )
                ],
              ),
              const SizedBox(height: 40),
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppPalette.greyColor,
                      ),
                  children: [
                    TextSpan(
                      text: "Log In",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppPalette.greyColor,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            LogInPage.route(),
                          );
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
