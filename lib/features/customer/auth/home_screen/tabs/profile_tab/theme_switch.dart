import 'package:flutter/material.dart';
import 'package:app/providers/theme_provider.dart';
class ThemeSwitchTile extends StatelessWidget {
  final AppThemeProvider themeProvider;
  final bool isDark;
  const ThemeSwitchTile({
    Key? key,
    required this.themeProvider,
    required this.isDark,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String titleText = isDark ? "Dark Mode" : "Light Mode";
    final IconData iconData =
    isDark ? Icons.nightlight_round : Icons.wb_sunny_rounded;
    return ListTile(
      leading: Icon(
        iconData,
        color: Colors.orange,
        size: 22,
      ),
      title: Text(
        titleText,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      trailing: Switch.adaptive(
        value: isDark,
        onChanged: (val) =>
            themeProvider.changeTheme(
              val ? ThemeMode.dark : ThemeMode.light,
            ),
        activeColor: Colors.blue,
      ),
    );
  }
}
