import 'package:flutter/material.dart';

import '../screens/user_profile.dart';
class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({
    super.key,
  });

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
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(
            size: 40,
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'User',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ))
        ],
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white,
              ),
              CircleAvatar(
                radius: 18,
                backgroundImage:
                AssetImage('assets/images/person.png'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
