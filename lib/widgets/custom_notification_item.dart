import 'package:flutter/material.dart';
import 'package:app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<bool> onChanged;

  const NotificationItem({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // بنعرف الـ provider هنا جوه الـ build عشان نستخدمه في الألوان
    var themeProvider = Provider.of<AppThemeProvider>(context); // أو AppThemeProvider حسب اسم الكلاس عندك

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(
              icon,
              // الأيقونة تكون بيضاء في الدارك وزرقاء أو رمادية في اللايت
              color: themeProvider.isDarkTheme() ? Colors.white : Colors.blueGrey,
              size: 24
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                // النص لونه يقلب حسب الثيم
                color: themeProvider.isDarkTheme() ? Colors.white : Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Switch(
            value: isSelected,
            onChanged: onChanged,
            activeThumbColor: Colors.blue,
            // لون المجرى (Track) برضه يتغير
            activeTrackColor: Colors.blue.withValues(alpha: 0.3),
            inactiveTrackColor: themeProvider.isDarkTheme() ? Colors.white24 : Colors.grey[300],
          ),
        ],
      ),
    );
  }
}