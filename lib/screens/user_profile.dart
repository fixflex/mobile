import 'package:flutter/material.dart';

import '../components/list_tile_button.dart';
import '../models/custom_clippers.dart';
import '../models/list_tile_model.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key});
  final List<ListTileModel> listTileOptions = [
    ListTileModel(
      leading: Icons.credit_card,
      title: 'Payment Options',
      trailing: Icons.arrow_forward_ios,
    ),
    ListTileModel(
      leading: Icons.notifications,
      title: 'Notifications',
      trailing: Icons.arrow_forward_ios,
    ),
    ListTileModel(
      leading: Icons.lock_person,
      title: 'Personal Information',
      trailing: Icons.arrow_forward_ios,
    ),
    ListTileModel(
      leading: Icons.help,
      title: 'Help',
      trailing: Icons.arrow_forward_ios,
    ),
    ListTileModel(
      leading: Icons.message,
      title: 'Contact Us',
      trailing: Icons.arrow_forward_ios,
    ),
    ListTileModel(
      leading: Icons.policy,
      title: 'Policy',
      trailing: Icons.arrow_forward_ios,
    ),
    ListTileModel(
      leading: Icons.logout,
      title: 'Log Out',
      trailing: Icons.arrow_forward_ios,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipPath(
                  clipper: FifthClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    color: Color(0xff134161),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 25,
                            right: 20,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 43,
                                backgroundColor: Colors.white,
                              ),
                              CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    AssetImage('assets/images/person.png'),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 140,
                              child: Text(
                                'Fix Flex Fix Flex',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                'Cairo, Egypt PlaPla' ,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            'ACCOUNT SETTINGS',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        ListView.builder(
                          padding: EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTileButton(
                              listTileModel: listTileOptions[index],
                            );
                          },
                          itemCount: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:25,bottom: 8,),
                          child: Text(
                            'HELP & SUPPORT',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        ListView.builder(
                          padding: EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTileButton(
                              listTileModel: listTileOptions[index + 3],
                            );
                          },
                          itemCount: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:25,bottom: 8,),
                          child: Text(
                            'SAFETY',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        ListView.builder(
                          padding: EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTileButton(
                              listTileModel: listTileOptions[index + 5],
                            );
                          },
                          itemCount: 2,
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 220,
              child: Container(
                width: 120,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[400],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
