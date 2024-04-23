import 'package:flutter/widgets.dart';

class ListTileModel {
  final IconData leading;
  final String title;
  final IconData trailing;
  final Function onTap;

  ListTileModel({
    required this.leading,
    required this.title,
    required this.trailing,
    required this.onTap,
  });
}