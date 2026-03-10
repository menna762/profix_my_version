import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isDark;
  final String? trailingText;
  final VoidCallback? onTap;

  const MenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.isDark,
    this.trailingText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: isDark ? Colors.blueAccent : Colors.blueGrey,
        size: 22,
      ),
      title: Text(
        title,
        style:  TextStyle(
          color: isDark ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(
              trailingText!,
              style: const TextStyle(color: Colors.grey),
            ),
          const SizedBox(width: 5),
           Icon(
            Icons.arrow_forward_ios_rounded,
            color: isDark ? Colors.white38 : Colors.grey,
            size: 14,
          ),
        ],
      ),
    );
  }
}
