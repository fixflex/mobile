import 'package:flutter/material.dart';

Widget customTextButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return TextButton(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xff292F3F),
      backgroundColor: Colors.white,
      fixedSize: const Size(400, 55),
    ),
    onPressed: onPressed,
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 20,
      ),
    ),
  );
}