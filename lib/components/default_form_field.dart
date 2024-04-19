import 'package:flutter/material.dart';

//TFF
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyType,
  Function(String)? onSubmit,
  Function(String)? onChanged,
  required String? Function(String?)? validate,
  required IconData prefix,
  String? label,
  IconData? suffix,
  String? hint,
  Color? fillColor,
  bool isPassword = false,
  void Function()? suffixPressed,
}) =>
    SizedBox(
      width: 330,
      child: TextFormField(
        controller: controller,
        keyboardType: keyType,
        onFieldSubmitted: onSubmit,
        onChanged: onChanged,
        validator: validate,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          filled: true,
          fillColor: fillColor,
          prefixIcon: Icon(
            prefix,
            color: const Color(0xff134161),
          ),
          suffixIcon: IconButton(
            onPressed: suffixPressed,
            icon: Icon(suffix),
            color: const Color(0xff134161),
          ),
          labelText: label,
          labelStyle: TextStyle(color:  Color(0xff134161)),
          hintText: hint,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        obscureText: isPassword,
      ),
    );
