import 'package:fix_flex/components/task_container.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const String id = 'OrdersScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TaskContainer(),
                TaskContainer(),
                TaskContainer(),
                TaskContainer(),
                TaskContainer(),
                TaskContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
