import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/widgets/custom_text_field.dart';
import 'package:app/widgets/custom_upload_profile_image.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/user_provider.dart';
import 'package:app/providers/theme_provider.dart';
import 'package:app/core/services/auth_service.dart';

class EditProfilePage extends StatefulWidget {
  static String routeName = "editProfilePage";
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  late final AuthService _authService;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    nameController.text = userProvider.name ?? '';
    emailController.text = userProvider.email ?? '';
    phoneController.text = userProvider.phone ?? '';
  }

  Future<void> _handleImageSelection() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      setState(() => _profileImage = File(pickedFile.path));
    }
  }

  void _handleImageDeletion() {
    setState(() => _profileImage = null);
  }

  Future<void> _saveChanges() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final localizations = AppLocalizations.of(context)!;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      Map<String, dynamic> updateData = {
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
      };

      final response = await _authService.updateUser(
        userProvider.userId!,
        updateData,
        imagePath: _profileImage?.path,
      );

      userProvider.updateProfile(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        profileImage: response['profileImage'],
      );

      setState(() {
        _profileImage = null;
      });

      if (!mounted) return;
      Navigator.of(context).pop(); 
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localizations.profileUpdatedSuccessfully),
          backgroundColor: Colors.green[600],
          duration: const Duration(seconds: 3),
        ),
      );

      Navigator.of(context).pop(); 
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop(); 
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${localizations.failedToUpdateProfile}: ${e.toString()}'),
          backgroundColor: Colors.red[600],
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final isDark = themeProvider.isDarkTheme();
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F1729) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF0F1729) : Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: isDark ? Colors.white : Colors.black, size: 20),
          onPressed: () =>  Navigator.pop(context)
        ),
        title: Text(localizations.editProfile,
            style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  CustomUploadProfileImage(
                    imageFile: _profileImage,
                    onTap: _handleImageSelection,
                    onDelete: _handleImageDeletion,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.crop_original, size: 18, color: isDark ? Colors.white38 : Colors.grey),
                      const SizedBox(width: 5),
                      Text(localizations.tapToChangePhoto,
                          style: TextStyle(color: isDark ? Colors.white38 : Colors.grey[600], fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            _buildLabel(localizations.fullName, isDark),
            CustomTextField(
              controller: nameController,
              hintText: localizations.fullName,
            ),

            const SizedBox(height: 20),

            _buildLabel(localizations.email, isDark),
            CustomTextField(
              controller: emailController,
              hintText: localizations.email,
              isEditable: false,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 4),
              child: Text(
                localizations.emailCannotBeChanged,
                style: TextStyle(color: Colors.red[400], fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),

            const SizedBox(height: 20),

            _buildLabel(localizations.phoneNumber, isDark),
            CustomTextField(
              controller: phoneController,
              hintText: localizations.phoneNumber,
            ),

            const SizedBox(height: 20),

            _buildLabel(localizations.defaultAddress, isDark),
            CustomTextField(
              controller: addressController,
              hintText: localizations.enterDefaultAddress,
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007BFF),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.save_outlined, size: 22),
                    const SizedBox(width: 10),
                    Text(localizations.saveChanges,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 2),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}
