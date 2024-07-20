import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:junkpoint/core/common/widgets/loader.dart';
import 'package:junkpoint/core/theme/app_palette.dart';
import 'package:junkpoint/core/utils/show_snackbar.dart';
import 'package:junkpoint/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:junkpoint/features/auth/presentation/pages/login_page.dart';
import 'package:junkpoint/features/auth/presentation/widgets/auth_button.dart';
import 'package:junkpoint/features/auth/presentation/widgets/auth_field.dart';
import 'package:junkpoint/features/auth/presentation/widgets/auth_other_button.dart';
import 'package:junkpoint/features/orders/presentation/pages/orders_page.dart';

class ShopSignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ShopSignUpPage(),
      );
  const ShopSignUpPage({super.key});

  @override
  State<ShopSignUpPage> createState() => _ShopSignUpPageState();
}

class _ShopSignUpPageState extends State<ShopSignUpPage> {
  final nameController = TextEditingController();
  final credentialController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool emailMode = true;

  @override
  void dispose() {
    credentialController.dispose();
    nameController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPalette.mainColor,
        foregroundColor: AppPalette.whiteColor,
        centerTitle: true,
        title: const Text(
          "JUNKPOINT",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            } else if (state is AuthSuccess) {
              Navigator.push(context, OrdersPage.route());
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
                    const Text(
                      "Create a Junk Shop Account",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppPalette.greyColor,
                      ),
                    ),
                    const SizedBox(height: 15),
                    AuthField(
                        hintText: "Shop Name", controller: nameController),
                    const SizedBox(height: 15),
                    AuthField(
                        hintText: emailMode ? "Email Address" : "Phone Number",
                        controller: credentialController),
                    const SizedBox(height: 15),
                    AuthField(
                      hintText: "Password",
                      controller: passwordController,
                      isObscureText: true,
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: AuthButton(
                        buttonText: "Sign Up",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  AuthSignUp(
                                    credential:
                                        credentialController.text.trim(),
                                    name: nameController.text.trim(),
                                    password: passwordController.text.trim(),
                                    role: "shop",
                                  ),
                                );
                          }
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: const Divider(
                              color: AppPalette.borderColor,
                              height: 48,
                            ),
                          ),
                        ),
                        const Text("or"),
                        Expanded(
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: const Divider(
                              color: AppPalette.borderColor,
                              height: 48,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AuthOtherButton(
                      provider: emailMode ? "Phone Number" : "Email Address",
                      icon: emailMode
                          ? FontAwesomeIcons.phone
                          : FontAwesomeIcons.solidEnvelope,
                      onPressed: () {
                        setState(() {
                          emailMode = !emailMode;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    AuthOtherButton(
                      provider: "Google",
                      icon: FontAwesomeIcons.google,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 15),
                    AuthOtherButton(
                      provider: "Facebook",
                      icon: FontAwesomeIcons.facebook,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppPalette.greyColor,
                                ),
                        children: [
                          TextSpan(
                            text: "Log In",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
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
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
