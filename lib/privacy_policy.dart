import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'privacy_statement_text.dart';

class PolicyInfoPage extends StatelessWidget {
  const PolicyInfoPage({super.key});

  // Function to launch email app
  _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Privacy%20Inquiry', // preset the subject if you want
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Last updated: [Date]',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Your privacy is very important to us. This Privacy Policy outlines the types of information that we may collect and hold, how that information is used, and with whom the information is shared.',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 20.0),
              const Text(
                PrivacyStatement.statement,
                style: TextStyle(fontSize: 16.0),
              ),
              // Contact Us Section
              const SizedBox(height: 20.0),
              const Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15.0),
              GestureDetector(
                onTap: () => _launchEmail(
                    'travel.time.converter@gmail.com'), // Your email
                child: const Text(
                  'For any privacy-related inquiries, please email us at travel.time.converter@gmail.com',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              // ... Continue adding more sections as required ...
            ],
          ),
        ),
      ),
    );
  }
}
