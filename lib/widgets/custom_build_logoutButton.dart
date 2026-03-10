import 'package:flutter/material.dart';



class LogoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LogoutButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.redAccent.withValues(alpha: 0.1),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: onPressed,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout, color: Colors.redAccent),
          SizedBox(width: 8),
          Text(
            "Log Out",
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
