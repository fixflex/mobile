import 'package:fix_flex/screens/personal_information_screen.dart';
import 'package:flutter/material.dart';

import '../screens/user_profile.dart';

class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onPressed,
    this.iconSize,
    this.image,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final double? iconSize;
  final void Function()? onPressed;
  final String? image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      forceElevated: true,
      shadowColor: const Color(0xff306686),
      // scrolledUnderElevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(50),
        ),
      ),
      backgroundColor: Color(0xff134161),
      // expandedHeight: 140,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(20),
        child: new Container(),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: iconSize,
            color: Colors.white,
          ),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: onTap,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(image!),
                  // backgroundImage: AssetImage('assets/images/person.png'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
