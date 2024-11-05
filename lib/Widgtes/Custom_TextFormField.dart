import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({super.key, this.onchanged, this.Hint, this.obscureText = false});

  Function(String)? onchanged;
  String? Hint;
  bool obscureText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      validator: (value) {
        if (value!.isEmpty) {
          return "هذا الحقل مطلوب";
        }
        return null;
      },
      onChanged: widget.onchanged,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.purple,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              widget.obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                widget.obscureText = !widget.obscureText;
              });
            },
          ),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15)),
          hintText: widget.Hint,
          hintStyle: const TextStyle(color: Colors.white, fontSize: 15)),
    );
  }
}
