import 'package:app/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/features/customer/auth/home_screen/language_bottom_sheet.dart';
import 'package:app/features/customer/auth/home_screen/tabs/profile_tab/custom_menu_item.dart';
import 'package:app/features/customer/auth/home_screen/tabs/profile_tab/userInfoHeader.dart';
import 'package:app/features/customer/auth/home_screen/tabs/profile_tab/switch_menu_item.dart';
import 'package:app/features/customer/auth/home_screen/tabs/profile_tab/theme_switch.dart';
import 'package:app/features/technican/profile_technican/professional/customer_reviews_page.dart';
import 'package:app/features/technican/profile_technican/professional/service_categories_page.dart';
import 'package:app/features/technican/profile_technican/professional/service_areas_page.dart';
import 'package:app/providers/language_provider.dart';
import 'package:app/providers/theme_provider.dart';
import 'package:app/providers/user_provider.dart';
import 'package:app/utils/profix_images.dart';
import 'package:app/widgets/custom_build_logoutButton.dart';
import 'package:app/features/technican/profile_technican/availabilityCard.dart';
import 'package:provider/provider.dart';

class TechnicianProfileTab extends StatefulWidget {
  const TechnicianProfileTab({super.key});
  static String routeName = "technicalProfile";
  @override
  State<TechnicianProfileTab> createState() => _TechnicianProfileTabState();
}

class _TechnicianProfileTabState extends State<TechnicianProfileTab> {
  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const LanguageBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    bool isDark = themeProvider.isDarkTheme();

    // Get dynamic data from provider
    String currentName = userProvider.name ?? 'Technician';
    String currentEmail = userProvider.email ?? '';
    String currentPhone = userProvider.phone ?? '';
    String currentImagePath = userProvider.profileImage ?? ProfixImages.routeImage;

    return Scaffold(
        backgroundColor: isDark ? const Color(0xFF0F1729) : const Color(0xFFF8F9FA),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 60),
                  UserInfoHeader(
                    userName: currentName,
                    userRole: "Technician",
                    email: currentEmail,
                    phone: currentPhone,
                    imagePath: currentImagePath,
                    rate: userProvider.rate ?? 4.8,
                    totalJobs: userProvider.totalJobs ?? 150,
                    showRate: true,
                    onEditTap: onEditTap,
                  ),
                  SizedBox(height: 30,),
                  AvailabilityCard(),
                  SizedBox(height: 30,),

                  _buildSectionTitle("Professional"),
                  _buildGroupedContainer(isDark, [
                    _buildDivider(isDark),
                    MenuItem(icon: Icons.verified_outlined,
                        title: "Varification", isDark: isDark,onTap: (){
                        Navigator.pushNamed(context, "verification");
                      },),
                    _buildDivider(isDark),
                    MenuItem(icon: Icons.build_outlined,
                        title: "Service Categories" ,
                        isDark: isDark,
                        onTap: (){
                          Navigator.pushNamed(context, ServiceCategoriesPage.routeName);
                        }),
                    _buildDivider(isDark),
                    MenuItem(icon: Icons.location_on_outlined,
                        title: "Service Areas", isDark: isDark,
                        onTap: (){
                          Navigator.pushNamed(context, ServiceAreasPage.routeName);
                        }),
                    _buildDivider(isDark),
                    MenuItem(
                      icon: Icons.star_border_outlined,
                      title: "Customer Reviews",
                      isDark: isDark,
                      onTap: () {
                        Navigator.pushNamed(context, CustomerReviewsPage.routeName);
                      },
                    ),
                  ]),
                  const SizedBox(height: 30),
                  _buildSectionTitle("Account"),
                  _buildGroupedContainer(isDark, [
                    MenuItem(icon: Icons.location_on_outlined,
                        title: "My Addresses",
                        isDark: isDark,onTap: (){
                         Navigator.pushNamed(context, "technicalAddress");
                      },),

                    _buildDivider(isDark),
                    MenuItem(icon: Icons.security_outlined,
                        title: "Security & Privacy", isDark: isDark,onTap: (){
                        Navigator.pushNamed(context, "TechnicalSecurityPrivacy");
                      },)
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionTitle("Preferences"),
                  _buildGroupedContainer(isDark, [
                    MenuItem(icon:Icons.language,
                      title: "Language",
                      isDark: isDark,
                      trailingText: languageProvider.appLanguage == 'en' ? "English" : "العربية",
                      onTap: () => showLanguageBottomSheet(),  ),

                    _buildDivider(isDark),
                    ThemeSwitchTile(themeProvider: themeProvider, isDark: isDark
                    ),
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionTitle("Notifications"),
                  _buildGroupedContainer(isDark, [
                    SwitchMenuItem(icon:Icons.notifications_none_outlined,
                      title: 'New Requests',
                      value: true,
                      onChanged: (bool value) {  },
                      isDark: isDark,
                    ),
                    _buildDivider(isDark),
                    SwitchMenuItem(icon: Icons.check_circle_outline_rounded,
                        title: "Status Updates", value: true, onChanged: (val) {}
                        , isDark: isDark),
                    _buildDivider(isDark),
                    SwitchMenuItem(icon: Icons.mail_outline_rounded,
                        title: "New Messages",
                        value: true, onChanged: (val){}, isDark: isDark)
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionTitle("Help & Support"),
                  _buildGroupedContainer(isDark, [
                    MenuItem(icon:Icons.help_outline_rounded ,
                      title: "FAQ",
                      isDark: isDark,
                      onTap: (){},
                    ),
                    _buildDivider(isDark),
                    MenuItem(icon: Icons.mail_outline_rounded,
                        title: "Contact Us",
                        onTap: (){},
                        isDark: isDark),
                  ]),
                  SizedBox(height: 32),
                  LogoutButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
                    },
                  ),
                  const SizedBox(height: 30),

                ]),
          ),
        )
    );
  }
  onEditTap(){
    return Navigator.pushNamed(context, "editProfilePageForTechnical");
  }
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }
  Widget _buildGroupedContainer(bool isDark, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A2235) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (!isDark) BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, spreadRadius: 5),
        ],
      ),
      child: Column(children: children),
    );
  }
  Widget _buildDivider(bool isDark) {
    return Divider(height: 1, indent: 50, endIndent: 15, color: isDark ? Colors.white10 : Colors.grey[100]);
  }
}