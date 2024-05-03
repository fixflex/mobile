import 'package:flutter/material.dart';
class BecomeATaskerScreen extends StatelessWidget {
  const BecomeATaskerScreen({super.key});

  static const String id = 'BecomeATaskerScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Become a Tasker'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the tasker registration screen
            // Navigator.of(context).pushNamed('/tasker-registration');
          },
          child: Text('Become a Tasker'),
        ),
      ),
    );
  }
}
