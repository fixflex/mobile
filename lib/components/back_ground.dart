import 'package:fix_flex/constants/constants.dart';
import 'package:flutter/material.dart';

import '../models/custom_clippers.dart';
class BackGround extends StatelessWidget {
  const BackGround({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: FirstClipper(),
          child: Container(
            color: const Color(0xffd7e0e6),
          ),
        ),
        ClipPath(
          clipper: SecondClipper(),
          child: Container(
            color: const Color(0xff92d3f3),
          ),
        ),
        ClipPath(
          clipper: ThirdClipper(),
          child: Container(
            color: const Color(0xff306686),
          ),
        ),
        ClipPath(
          clipper: FourthClipper(),
          child: Container(
            color: kPrimaryColor,
          ),
        ),
      ],
    );
  }
}
