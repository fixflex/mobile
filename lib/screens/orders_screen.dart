import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const String id = 'OrdersScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Orders'),),);
  }
}
