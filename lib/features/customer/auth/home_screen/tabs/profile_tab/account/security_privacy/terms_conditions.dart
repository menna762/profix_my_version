import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});
  static String routeName = "TermsConditionsPage";
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
          'Terms & Conditions',
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
              _buildSectionTitle('1. Acceptance of Terms'),
              _buildSectionBody('By using PROFIX, you agree to these terms. The platform connects customers with verified maintenance technicians.'),

              const SizedBox(height: 20),

              _buildSectionTitle('2. User Responsibilities'),
              _buildSectionBody('Users must provide accurate information. Misuse of the platform may result in account suspension.'),

              const SizedBox(height: 20),

              _buildSectionTitle('3. Service Guarantee'),
              _buildSectionBody('PROFIX acts as a facilitator between customers and technicians. Service quality is the responsibility of the technician.'),

              const SizedBox(height: 20),

              _buildSectionTitle('4. Payment & Refunds'),
              _buildSectionBody("Payment terms are agreed upon between customer and technician. PROFIX may charge a service fee."),
              const SizedBox(height: 20),
              _buildSectionTitle("5. Modifications"),
              _buildSectionBody("These terms may be updated. Continued use indicates acceptance of updated terms.")
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