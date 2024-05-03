import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//TFF
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyType,
  Function(String)? onSubmit,
  Function(String)? onChanged,
  required String? Function(String?)? validate,
  required IconData prefix,
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
  List<TextInputFormatter>? inputFormatters,
  void Function(String?)? onSaved,
  double? width,
  String? counterText,
  TextStyle? hintStyle,
  int? maxLength,
  int? maxLines = 1,
  String? label,
  IconData? suffix,
  String? hint,
  Color? fillColor = Colors.white,
  bool isPassword = false,
  void Function()? suffixPressed,
}) =>
    SizedBox(
      width: width,
      child: TextFormField(
        maxLength: maxLength,
        maxLines: maxLines,
        inputFormatters: inputFormatters,
        autovalidateMode: autoValidateMode,
        controller: controller,
        keyboardType: keyType,
        onFieldSubmitted: onSubmit,
        onChanged: onChanged,
        validator: validate,
        onSaved: onSaved,
        decoration: InputDecoration(
          counterText: counterText,
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
          hintStyle: hintStyle,
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
