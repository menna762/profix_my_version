import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/theme_provider.dart';
import 'package:app/l10n/app_localizations.dart';

class CustomerReviewsPage extends StatelessWidget {
  const CustomerReviewsPage({super.key});
  static String routeName = "customerReviews";

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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          localizations.customerReviews ?? "Customer Reviews",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star_outline,
              size: 80,
              color: isDark ? Colors.white24 : Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              localizations.noReviewsYet ?? "No reviews yet",
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.grey.shade600,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
