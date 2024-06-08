import 'package:fix_flex/constants/constants.dart';
import 'package:fix_flex/screens/contact_us_screen.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        alignment: Alignment.center,
        child: Text(
          "Terms And Conditions",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),
        ),
      ),
      Padding(
        padding:
            const EdgeInsets.only(right: 15, left: 15, top: 120, bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Introduction'),
              _buildSectionContent(
                  'Welcome to Fix Flex! These terms govern your use of our app. By using our services, you agree to these terms.'),
              _buildSectionTitle('Acceptance of Terms'),
              _buildSectionContent(
                  'Creating an account means you accept these terms. If you don\'t agree, do not use the app.'),
              _buildSectionTitle('User Responsibilities'),
              _buildSectionContent(
                  '- Provide accurate task details.\n- Ensure tasks comply with laws.\n- Communicate clearly with taskers.\n- Pay upon task completion.'),
              _buildSectionTitle('Tasker Responsibilities'),
              _buildSectionContent(
                  '- Provide accurate offer details.\n- Complete tasks as agreed.\n- Communicate clearly with users.\n- Ensure quality and safety of work.'),
              _buildSectionTitle('Payments and Fees'),
              _buildSectionContent(
                  '- Users select a budget for tasks.\n- Taskers make offers within or outside this budget.\n- Payments are processed securely.\n- We may charge a service fee.'),
              _buildSectionTitle('Cancellations and Refunds'),
              _buildSectionContent(
                  '- Users can cancel tasks before acceptance.\n- Taskers can withdraw offers before acceptance.\n- Refunds follow our policy.'),
              _buildSectionTitle('Dispute Resolution'),
              _buildSectionContent(
                  '- Resolve disputes directly if possible.\n- Our support can mediate if needed.'),
              _buildSectionTitle('Limitation of Liability'),
              _buildSectionContent(
                  '- We aren\'t liable for damages from using our services.\n- Liability is limited to the amount paid.'),
              _buildSectionTitle('Privacy Policy'),
              _buildSectionContent(
                  '- We protect your personal information.\n- Refer to our Privacy Policy for details.'),
              _buildSectionTitle('Changes to Terms'),
              _buildSectionContent(
                  '- We can modify these terms anytime.\n- We\'ll notify you of significant changes.\n- Continued use after changes means acceptance.'),
              _buildSectionTitle('Contact Information'),
              _buildSectionContent(
                  'For any questions, please contact us at...'),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ContactUsScreen()));
                  },
                  child: Text(
                    "fixflex@gmail.com",
                    style: TextStyle(
                      color: kPrimaryColor,
                    ),
                  )),
            ],
          ),
        ),
      ),
    ]));
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(fontSize: 16, color: Colors.black),
    );
  }
}
