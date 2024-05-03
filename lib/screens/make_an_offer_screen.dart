import 'package:flutter/material.dart';
class MakeAnOfferScreen extends StatelessWidget {
  const MakeAnOfferScreen({super.key});

  static const String id = 'MakeAnOfferScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make An Offer'),
      ),
      body: Center(
        child: Text('Make An Offer Screen'),
      ),
    );
  }
}
