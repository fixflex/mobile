import 'package:flutter/material.dart';

import '../../constants/constants.dart';

Widget customTextForm({
  IconData? prefix,
  IconData? suffix,
  Function()? onSuffixPressed,
  required String labletext,
  Function(String)? onChanged,
  required String? Function(String?)? validator,
  required TextInputType keyboardType,
  required TextEditingController controller,
  bool obscureText = false,
}) {
  return SizedBox(
    width: 400,
    height: 80,
    child: TextFormField(
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        helperText: ' ',
        prefixIcon: Icon(
          prefix,
          color: Colors.white,
        ),
        label: Text(
          labletext,
          style: const TextStyle(
            color: kThirdColor,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: onSuffixPressed,
          icon: Icon(suffix),
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: kThirdColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: kThirdColor,
          ),
        ),

      ),
    ),
  );
}
