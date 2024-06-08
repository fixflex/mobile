// import 'package:flutter/material.dart';
//
// import '../constants/constants.dart';
//
// class PrivacyPoliciesScreen extends StatelessWidget {
//   const PrivacyPoliciesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(children: [
//       Container(
//         height: 120,
//         width: double.infinity,
//         decoration: BoxDecoration(
//             color: kPrimaryColor,
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(50),
//                 bottomRight: Radius.circular(50))),
//         alignment: Alignment.center,
//         child: Text(
//           "Privacy Policies",
//           style: TextStyle(
//               fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),
//         ),
//       ),
//       Padding(
//         padding:
//             const EdgeInsets.only(right: 30, left: 30, top: 120, bottom: 10),
//         child: Expanded(
//           child: ListView(
//             children: [
//               Container(
//                 color: Colors.white,
//                 child: Theme(
//                   data: Theme.of(context)
//                       .copyWith(dividerColor: Colors.transparent),
//                   child: ExpansionTile(
//                     leading: Icon(
//                       Icons.info_outline,
//                       color: kPrimaryColor,
//                     ),
//                     title: _buildBoldTitle('Information We Collect'),
//                     iconColor: kPrimaryColor,
//                     children: [
//                       listTileExpansion("Personal Information",
//                           "We may collect personal information such as your name, email address, phone number, and location when you register on our app or use our services."),
//                       listTileExpansion("Task Information",
//                           "When you post a task or make an offer on a task, we collect details about the task including description, budget, and any other related information."),
//                       listTileExpansion("Usage Data",
//                           "We may collect information about how you access and use the app, including your interactions with the app, your device information, and log data.")
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 color: Colors.white,
//                 child: Theme(
//                   data: Theme.of(context)
//                       .copyWith(dividerColor: Colors.transparent),
//                   child: ExpansionTile(
//                     leading: Icon(
//                       Icons.info_outline_rounded,
//                       color: kPrimaryColor,
//                     ),
//                     title: _buildBoldTitle('How We Use Your Information'),
//                     iconColor: kPrimaryColor,
//                     children: [
//                       listTileExpansion("To Provide and Manage Services",
//                           "We use your information to facilitate the tasks posted and offers made on the app, and to communicate with you about your tasks and offers"),
//                       listTileExpansion("To Improve Our Services",
//                           " We may use your information to understand how our users interact with the app and to enhance user experience."),
//                       listTileExpansion("To Communicate with You",
//                           "We use your information to send you updates, promotional materials, and other information that may be of interest to you.")
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 color: Colors.white,
//                 child: Theme(
//                   data: Theme.of(context)
//                       .copyWith(dividerColor: Colors.transparent),
//                   child: ExpansionTile(
//                     leading: Icon(
//                       Icons.info_outline_rounded,
//                       color: kPrimaryColor,
//                     ),
//                     title: _buildBoldTitle('Sharing Your Information'),
//                     iconColor: kPrimaryColor,
//                     children: [
//                       listTileExpansion("With Taskers and Users",
//                           "Your task-related information will be shared with taskers and users to facilitate the matching and completion of tasks."),
//                       listTileExpansion("Service Providers",
//                           "We may share your information with third-party service providers that help us operate and maintain our app."),
//                       listTileExpansion("Legal Requirements",
//                           "We may disclose your information to comply with legal obligations or in response to lawful requests by public authorities."),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 color: Colors.white,
//                 child: Theme(
//                   data: Theme.of(context)
//                       .copyWith(dividerColor: Colors.transparent),
//                   child: ExpansionTile(
//                     leading: Icon(
//                       Icons.security_outlined,
//                       color: kPrimaryColor,
//                     ),
//                     title: _buildBoldTitle('Data Security'),
//                     iconColor: kPrimaryColor,
//                     children: [
//                       _buildSectionContent(
//                           "We use administrative, technical, and physical security measures to protect your personal information. However, no security system is impenetrable, and we cannot guarantee the security of our systems 100%.")
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 color: Colors.white,
//                 child: Theme(
//                   data: Theme.of(context)
//                       .copyWith(dividerColor: Colors.transparent),
//                   child: ExpansionTile(
//                     leading: Icon(
//                       Icons.privacy_tip_outlined,
//                       color: kPrimaryColor,
//                     ),
//                     title: _buildBoldTitle('Your Privacy Rights'),
//                     iconColor: kPrimaryColor,
//                     children: [
//                       listTileExpansion("Access and Update",
//                           "You can access and update your personal information through your account settings in the app."),
//                       listTileExpansion("Opt-Out",
//                           "You can opt-out of receiving promotional communications from us by following the unsubscribe instructions in those communications."),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 color: Colors.white,
//                 child: Theme(
//                   data: Theme.of(context)
//                       .copyWith(dividerColor: Colors.transparent),
//                   child: ExpansionTile(
//                     leading: Icon(
//                       Icons.privacy_tip_outlined,
//                       color: kPrimaryColor,
//                     ),
//                     title: _buildBoldTitle("Children'\s Privacy"),
//                     iconColor: kPrimaryColor,
//                     children: [
//                       _buildSectionContent(
//                           "Our app is not intended for use by children under the age of 13, and we do not knowingly collect personal information from children under 13. If we become aware that we have inadvertently received personal information from a child under 13, we will delete such information from our records.")
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 color: Colors.white,
//                 child: Theme(
//                   data: Theme.of(context)
//                       .copyWith(dividerColor: Colors.transparent),
//                   child: ExpansionTile(
//                     leading: Icon(
//                       Icons.privacy_tip_outlined,
//                       color: kPrimaryColor,
//                     ),
//                     title: _buildBoldTitle(' Changes to This Privacy Policy'),
//                     iconColor: kPrimaryColor,
//                     children: [
//                       _buildSectionContent(
//                           "We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the effective date.")
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ]));
//   }
//
//   Widget _buildBoldTitle(String content) {
//     return Text(
//       content,
//       style: TextStyle(
//           fontSize: 18, color: kPrimaryColor, fontWeight: FontWeight.w700),
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20),
//       child: Text(
//         title,
//         style: TextStyle(
//             fontSize: 16, fontWeight: FontWeight.w500, color: kPrimaryColor),
//       ),
//     );
//   }
//
//   Widget _buildSectionContent(String content) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: Text(
//         content,
//         style: TextStyle(fontSize: 14, color: Colors.black),
//       ),
//     );
//   }
//
//   Widget listTileExpansion(String title, String subTitle) {
//     return ExpansionTile(
//       // leading: icon  ,
//       iconColor: kPrimaryColor,
//       title: _buildSectionTitle(title),
//       children: [_buildSectionContent(subTitle)],
//     );
//   }
// }
