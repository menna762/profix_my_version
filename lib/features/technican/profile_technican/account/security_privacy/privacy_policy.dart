import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {

  static String routeName = "privacy_policy";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: Color(0xFF2D3E50), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Data Collection'),
              _buildSectionBody('We collect information you provide: name, email, phone, and location data to connect you with nearby technicians.'),

              const SizedBox(height: 20),

              _buildSectionTitle('Data Usage'),
              _buildSectionBody('Your data is used to match service requests, facilitate communication, and improve our platform.'),

              const SizedBox(height: 20),

              _buildSectionTitle('Data Sharing'),
              _buildSectionBody('Personal details are shared with assigned technicians only after request acceptance. We do not sell data to third parties.'),

              const SizedBox(height: 20),

              _buildSectionTitle('Data Security'),
              _buildSectionBody("We use industry-standard encryption and security measures to protect your information."),
              const SizedBox(height: 20),
              _buildSectionTitle("Your Rights"),
              _buildSectionBody("You may request data deletion at any time through the account settings.")
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2D3E50),
      ),
    );
  }
  Widget _buildSectionBody(String body) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        body,
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey.shade700,
          height: 1.5,
        ),
      ),
    );
  }
}