import 'package:flutter/material.dart';
import 'package:junkpoint/core/theme/app_palette.dart';

class AuthField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
  });

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
        if (value!.isEmpty) {
          return "${widget.hintText} is missing";
        }
        return null;
      },
      obscureText: isPasswordHidden,
    );
  }
}
