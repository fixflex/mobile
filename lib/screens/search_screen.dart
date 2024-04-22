import 'package:flutter/material.dart';


class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});


  static var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search'),),
    );
  }
}
