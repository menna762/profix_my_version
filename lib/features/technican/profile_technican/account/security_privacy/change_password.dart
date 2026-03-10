import 'package:flutter/material.dart';

import '../../../../../utils/profix_colors.dart';
class TechnicalChangePassword extends StatefulWidget {
  static String routeName = "ChangePasswordScreen";
  @override
  _TechnicalChangePasswordState createState() => _TechnicalChangePasswordState();
}
class _TechnicalChangePasswordState extends State<TechnicalChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20), // شكل سهم أشيك
            onPressed: () =>  Navigator.pop(context)
        ),
        title: Text("Change Password"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPasswordField(
                  label: "Current Password",
                  controller: _currentPasswordController,
                  isObscure: _obscureCurrent,
                  onToggle: () =>
                      setState(() => _obscureCurrent = !_obscureCurrent),
                ),
                SizedBox(height: 20),
                _buildPasswordField(
                  label: "New Password",
                  hint: "Min 8 characters",
                  controller: _newPasswordController,
                  isObscure: _obscureNew,
                  onToggle: () => setState(() => _obscureNew = !_obscureNew),
                  validator: (value) {
                    if (value == null || value.length < 8)
                      return "Password must be at least 8 characters";
                    return null;
                  },
                ),
                SizedBox(height: 20),
                _buildPasswordField(
                  label: "Confirm New Password",
                  controller: _confirmPasswordController,
                  isObscure: _obscureConfirm,
                  onToggle: () =>
                      setState(() => _obscureConfirm = !_obscureConfirm),
                  validator: (value) {
                    if (value != _newPasswordController.text)
                      return "Passwords do not match";
                    return null;
                  },
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: _updatePassword,
                    child: Text("Update Password",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildPasswordField({
    required String label,
    String? hint,
    required TextEditingController controller,
    required bool isObscure,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.grey[700])),
        SizedBox(height: 8),
        TextFormField(
          cursorColor: Colors.grey,
          controller: controller,
          obscureText: isObscure,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide(
              color: ProfixColors.blue
            )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color:ProfixColors.blue
                )
            ),
            suffixIcon: IconButton(
              icon: Icon(isObscure ? Icons.visibility_off_outlined : Icons
                  .visibility_outlined),
              onPressed: onToggle,
            ),
          ),
          validator: validator ??
                  (value) => value!.isEmpty ? "This field is required" : null,
        ),
      ],
    );
  }

void _updatePassword() {
  if (_formKey.currentState!.validate()) {
    // هنا تضعين كود الاتصال بـ API أو Firebase
    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;

    print("Sending to server: $newPassword");
    // مثال لإظهار رسالة نجاح
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Password updated successfully!")),
    );
  }
}
}