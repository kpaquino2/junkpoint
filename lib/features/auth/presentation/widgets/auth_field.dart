import 'package:flutter/material.dart';
import 'package:junkpoint/core/theme/app_palette.dart';

class AuthField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  final bool validate;

  const AuthField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.isObscureText = false,
      this.validate = true});

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool isPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.isObscureText
            ? const Icon(
                Icons.password,
                color: AppPalette.transparentColor,
              )
            : null,
        suffixIcon: widget.isObscureText
            ? IconButton(
                icon: Icon(
                  isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordHidden = !isPasswordHidden;
                  });
                },
              )
            : null,
      ),
      textAlign: TextAlign.center,
      validator: (value) {
        final String trimmedValue = value!.trim();
        if (trimmedValue.isEmpty) {
          return "${widget.hintText} is missing";
        }

        if (!widget.validate) return null;

        if (trimmedValue.length > 256) return "${widget.hintText} is too long";

        if (widget.hintText == "Email Address") {
          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(trimmedValue)) {
            return "Input is not a valid email address";
          }
        }

        if (widget.hintText == "Phone Number") {
          if (!RegExp(r"^((\+639)|(639)|(09))[0-9]{9}$")
              .hasMatch(trimmedValue)) {
            return "Invalid phone number";
          }
        }

        if (widget.hintText == "Password") {
          if (!RegExp(r"(?=.*?[A-Z]).*").hasMatch(trimmedValue)) {
            return "Password should contain at least one upper case character";
          }

          if (!RegExp(r"(?=.*?[a-z]).*").hasMatch(trimmedValue)) {
            return "Password should contain at least one lower case character";
          }

          if (!RegExp(r"(?=.*?[0-9]).*").hasMatch(trimmedValue)) {
            return "Password should contain at least one number";
          }

          if (!RegExp(r".{8,}").hasMatch(trimmedValue)) {
            return "Password should be at least 8 characters in length";
          }
        }

        return null;
      },
      obscureText: widget.isObscureText && isPasswordHidden,
    );
  }
}
