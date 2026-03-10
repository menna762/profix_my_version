import 'package:flutter/material.dart';

class SwitchMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isDark;

  const SwitchMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryTextColor = isDark ? Colors.white : Colors.black;
    final Color iconColor =
    isDark ? Colors.blue.shade300 : Colors.blue;

    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
        size: 22,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: primaryTextColor,
        ),
      ),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blue,
      ),
    );
  }
}
