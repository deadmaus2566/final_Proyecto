import 'package:flutter/material.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.white,
  );
}

class InputText extends StatefulWidget {
  final String? text;
  final IconData? icon;
  final bool? isPasswordType;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;

  InputText({
    Key? key,
    this.text,
    this.isPasswordType = false,
    this.controller,
    this.icon,
    this.validator,
  }) : super(key: key);

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.isPasswordType!,
      enableSuggestions: !widget.isPasswordType!,
      autocorrect: !widget.isPasswordType!,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white.withOpacity(0.9)),
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.icon,
          color: Colors.white70,
        ),
        labelText: widget.text,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
      ),
      keyboardType: widget.isPasswordType!
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    );
  }
}
