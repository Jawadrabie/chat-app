
import 'package:flutter/material.dart';

void ShowSnackBar(BuildContext context, String message, Color TheColor) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: TheColor, content: Text(message)));
}