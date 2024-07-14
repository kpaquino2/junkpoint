import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junkpoint/core/common/widgets/loader.dart';
import 'package:junkpoint/core/theme/app_palette.dart';
import 'package:junkpoint/core/utils/show_snackbar.dart';
import 'package:junkpoint/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:junkpoint/features/auth/presentation/pages/login_page.dart';
import 'package:junkpoint/features/auth/presentation/widgets/auth_button.dart';
import 'package:junkpoint/features/auth/presentation/widgets/auth_field.dart';

class ClientSignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ClientSignUpPage(),
      );
  const ClientSignUpPage({super.key});

  @override
  State<ClientSignUpPage> createState() => _ClientSignUpPageState();
}

class _ClientSignUpPageState extends State<ClientSignUpPage> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
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
        padding: const EdgeInsets.all(15),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
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
                      "Sign up as Client",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppPalette.greyColor,
                      ),
                    ),
                    const SizedBox(height: 15),
                    AuthField(hintText: "Name", controller: nameController),
                    const SizedBox(height: 15),
                    AuthField(
                        hintText: "Email Address", controller: emailController),
                    const SizedBox(height: 15),
                    AuthField(
                      hintText: "Password",
                      controller: passwordController,
                      isObscureText: true,
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: AuthButton(
                        buttonText: "Sign Up",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  AuthSignUp(
                                    email: emailController.text.trim(),
                                    name: nameController.text.trim(),
                                    password: passwordController.text.trim(),
                                    role: "client",
                                  ),
                                );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
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
                    )
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
