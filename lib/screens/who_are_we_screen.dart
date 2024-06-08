import 'package:flutter/material.dart';
import '../components/back_ground.dart';

class WhoAreWeScreen extends StatelessWidget {
  const WhoAreWeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          BackGround(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .13,
                    height: 1,
                    color: Colors.white,
                  ),
                  Center(
                    child: Text(
                      'Welcome to Fix Flex',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .13,
                    height: 1,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  'Our Mission and Vision',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  'Our mission is to provide a seamless and secure platform where users can easily find and hire qualified taskers for their specific needs. We envision a world where finding skilled help is quick, transparent, and hassle-free.',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 55.0),
              Center(
                child: Text(
                  'Our Values',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Center(child: buildValue('Trustworthy Service')),
              Center(child: buildValue('Customer Satisfaction')),
              Center(child: buildValue('Community Building')),
            ],
          )
        ],
      ),
    );
  }

  Widget buildValue(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
        ],
      ),
    );
  }
}
