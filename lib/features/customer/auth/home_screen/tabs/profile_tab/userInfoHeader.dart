import 'package:flutter/material.dart';
import 'package:app/providers/theme_provider.dart';
import 'package:app/providers/user_provider.dart';
import 'package:app/utils/profix_images.dart';
import 'package:provider/provider.dart';

class UserInfoHeader extends StatefulWidget {
  final String userName;
  final String userRole;
  final String email;
  final String phone;
  final String imagePath;
  final VoidCallback? onEditTap; // خليتها اختيارية ? عشان مش لازم تتبعت
  final double rate;
  final int totalJobs;
  final bool showRate;

  UserInfoHeader({
    super.key,
    // شيلنا required من كل اللي مش عاوزاه وحطينا قيم افتراضية
    required this.userName ,
    required this.userRole ,
   required this.email ,
    required this.phone ,
    required this.imagePath, // تأكدي من المسار
    this.rate=0,
    this.totalJobs=0,
    this.showRate=false,
    this.onEditTap,
  });

  @override
  State<UserInfoHeader> createState() => _UserInfoHeaderState();
}

class _UserInfoHeaderState extends State<UserInfoHeader> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDark = themeProvider.isDarkTheme();

    // Use dynamic data from provider instead of static parameters
    String currentImagePath = userProvider.profileImage ?? widget.imagePath;
    String currentUserName = userProvider.name ?? widget.userName;
    String currentEmail = userProvider.email ?? widget.email;
    String currentPhone = userProvider.phone ?? widget.phone;
    double currentRate = userProvider.rate ?? widget.rate;
    int currentTotalJobs = userProvider.totalJobs ?? widget.totalJobs;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // صورة البروفايل
              CircleAvatar(
                radius: 40,
                backgroundColor: isDark ? Colors.white10 : Colors.grey[200],
                backgroundImage: currentImagePath.isNotEmpty && currentImagePath != ProfixImages.routeImage
                    ? (currentImagePath.startsWith('http') 
                        ? NetworkImage(currentImagePath) as ImageProvider
                        : AssetImage(currentImagePath))
                    : null,
                child: currentImagePath.isEmpty || currentImagePath == ProfixImages.routeImage
                    ? Icon(Icons.person, size: 40, color: isDark ? Colors.white70 : Colors.grey[600])
                    : null,
              ),
              const SizedBox(width: 16),
              // الاسم والرتبة والتقييم
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentUserName,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.userRole,
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // --- الجزء الجديد: النجوم والتقييم ---
                    if (widget.showRate && userProvider.isTechnician())
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          "$currentRate",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          " • $currentTotalJobs jobs",
                          style: TextStyle(
                            color: isDark ? Colors.white60 : Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // زرار القلم (Edit Profile)
              InkWell(
                onTap: widget.onEditTap,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white10 : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.edit_outlined,
                    color: isDark ? Colors.white : Colors.blue,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildContactRow(Icons.email_outlined, currentEmail, isDark),
          const SizedBox(height: 12),
          _buildContactRow(Icons.phone_outlined, currentPhone, isDark),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text, bool isDark) {
    return Row(
      children: [
        Icon(icon, color: isDark ? Colors.white70 : Colors.black54, size: 20),
        const SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}