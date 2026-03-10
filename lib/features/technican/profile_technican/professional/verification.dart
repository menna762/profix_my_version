import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/theme_provider.dart';

class VerificationScreen extends StatefulWidget {
  static String routeName = "verification";
  const VerificationScreen({super.key});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _isUploaded = false; 
  String _fileName = "";    

  Future<void> _openGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _isUploaded = true; 
        _fileName = image.name; 
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Image Uploaded Successfully!"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final isDark = themeProvider.isDarkTheme();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios, 
            color: isDark ? Colors.white : Colors.black, 
            size: 20
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Verification",
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: isDark ? const Color(0xFF0F1729) : Colors.white,
      ),
      backgroundColor: isDark ? const Color(0xFF0F1729) : const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2C2115) : const Color(0xFFFFF7E6),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: isDark ? Colors.orange.withOpacity(0.2) : Colors.orange.shade100
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time_filled, color: Colors.orange, size: 30),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Account Verification: Pending Review",
                            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            "Upload all required documents to get verified",
                            style: TextStyle(color: Colors.orangeAccent, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              _buildDocCard(
                isDark: isDark,
                icon: Icons.credit_card,
                title: "National ID",
                subtitle: "national_id.jpg",
                statusWidget: _buildStatusChip("Pending Review", Colors.orange),
              ),
              const SizedBox(height: 15),

              _buildDocCard(
                isDark: isDark,
                icon: Icons.image_outlined,
                title: "Profile Photo",
                subtitle: "profile.jpg",
                statusWidget: _buildStatusChip("Approved", Colors.green, isApproved: true),
              ),
              const SizedBox(height: 15),

              _buildUploadCard(isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocCard({
    required bool isDark,
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget statusWidget,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A2235) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade200
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.withOpacity(0.1),
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isDark ? Colors.white38 : Colors.grey.shade500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          statusWidget,
        ],
      ),
    );
  }

  Widget _buildUploadCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A2235) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade200
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue.withOpacity(0.1),
                child: const Icon(Icons.description_outlined, color: Colors.blue),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Professional Certificate",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    if (_isUploaded) 
                      Text(
                        _fileName,
                        style: TextStyle(
                          color: isDark ? Colors.white38 : Colors.grey.shade500,
                          fontSize: 13,
                        ),
                      ),
                  ],
                ),
              ),
              _isUploaded
                  ? _buildStatusChip("Pending Review", Colors.orange)
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.file_upload_outlined, size: 14, color: isDark ? Colors.white38 : Colors.grey),
                          Text(
                            " Not Uploaded",
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white38 : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),

          if (!_isUploaded) ...[
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _openGallery,
                icon: Icon(Icons.upload_outlined, color: isDark ? Colors.white70 : Colors.black),
                label: Text(
                  "Upload",
                  style: TextStyle(color: isDark ? Colors.white70 : Colors.black),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: isDark ? Colors.white24 : Colors.grey.shade300),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildStatusChip(String text, Color color, {bool isApproved = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(isApproved ? Icons.check_circle_outline : Icons.access_time, color: color, size: 14),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
