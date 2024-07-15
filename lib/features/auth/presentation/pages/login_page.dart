import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junkpoint/core/common/widgets/green_circle_painter.dart';
import 'package:junkpoint/core/common/widgets/loader.dart';
import 'package:junkpoint/core/theme/app_palette.dart';
import 'package:junkpoint/core/utils/show_snackbar.dart';
import 'package:junkpoint/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:junkpoint/features/auth/presentation/pages/start_page.dart';
import 'package:junkpoint/features/auth/presentation/widgets/auth_button.dart';
import 'package:junkpoint/features/auth/presentation/widgets/auth_field.dart';
import 'package:junkpoint/features/orders/presentation/pages/orders_page.dart';
import 'package:junkpoint/features/shops/presentation/pages/shops_page.dart';

class LogInPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LogInPage(),
      );

  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFailure) {
                      showSnackBar(context, state.message);
                    } else if (state is AuthSuccess) {
                      if (state.uid.isLeft()) {
                        Navigator.push(context, ShopsPage.route());
                      }
                      if (state.uid.isRight()) {
                        Navigator.push(context, OrdersPage.route());
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Loader();
                    }
                    return Form(
                      key: formKey,
                      child: Center(
                        child: Column(
                          children: [
                            AuthField(
                              hintText: "Email Address",
                              controller: emailController,
                            ),
                            const SizedBox(height: 20),
                            AuthField(
                              hintText: "Password",
                              controller: passwordController,
                              isObscureText: true,
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: AuthButton(
                                buttonText: "Log In",
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                          AuthLogIn(
                                            email: emailController.text.trim(),
                                            password:
                                                passwordController.text.trim(),
                                          ),
                                        );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 30),
                            RichText(
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: AppPalette.greyColor,
                                    ),
                                children: [
                                  TextSpan(
                                    text: "Sign Up",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: AppPalette.greyColor,
                                            fontStyle: FontStyle.italic,
                                            decoration:
                                                TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          StartPage.route(),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
