import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/features/customer/auth/login/register/register_screen.dart';
import 'package:app/features/customer/auth/login/register/technician_register_screen.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/providers/user_provider.dart';
import 'package:app/providers/theme_provider.dart';
import 'package:app/widgets/cusstom_text_Button.dart';
import 'package:app/widgets/custom_eleveted_button.dart';
import 'package:app/widgets/custom_text_Widget.dart';
import 'package:app/widgets/custom_text_field.dart';
import 'package:app/utils/profixStyles.dart';
import 'package:app/utils/profix_colors.dart';
import 'package:provider/provider.dart';

import 'package:app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/core/network/api_client.dart';
import 'package:app/core/services/auth_service.dart';

import '../../../../screens/customer_home_screen.dart';
import '../../../../screens/landing_screen.dart';
import '../home_screen/main_navigator.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'loginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isObscured = true;

  late final AuthRepository _authRepository;
  late final AuthService _authService;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepositoryImpl(AuthRemoteDataSource());
    _authService = AuthService();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDark = themeProvider.isDarkTheme();

    var height = MediaQuery.of(context).size.height;
    // استقبال النوع المرسل (customer أو technician)
    final String userType = ModalRoute.of(context)?.settings.arguments as String? ?? 'customer';

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F1729) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF0F1729) : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LandingScreen(onSelectRole: (_) {})),
              (route) => false,
            );
          },
        ),
        title: Text(
          userType == 'customer' ? "Customer Login" : "Technician Login",
          style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 18),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.05),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: userType == 'customer' ? Colors.blue[50] : const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    userType == 'customer' ? Icons.person_outline : Icons.build_outlined,
                    size: 60,
                    color: userType == 'customer' ? Colors.blue[400] : Colors.green[600],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: ProfixColors.black),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Sign in to continue",
                  style: TextStyle(fontSize: 16, color: ProfixColors.gray),
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AppLocalizations.of(context)!.email,
                      style: const TextStyle(fontWeight: FontWeight.w500, color: ProfixColors.gray)),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Enter your email",
                  prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) return 'Please enter email';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AppLocalizations.of(context)!.password,
                      style: const TextStyle(fontWeight: FontWeight.w500, color: ProfixColors.gray)),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: "Enter your password",
                  obscureText: isObscured,
                  prefixIcon: const Icon(Icons.lock_outline, color: ProfixColors.gray),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                    icon: Icon(
                      isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: ProfixColors.gray,
                    ),
                  ),
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) return 'Please enter password';
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: forgetPassword,
                    child: Text(AppLocalizations.of(context)!.forget_password,
                        style: const TextStyle(color: ProfixColors.lightBlue)),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: CustomElevatedButton(
                    text: AppLocalizations.of(context)!.login,
                    onButtonClick: login,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                        text: AppLocalizations.of(context)!.dont_have_account,
                        textStyle: ProfixStyles.medium16black),
                    CusstomTextButton(
                      onButtonClicked: () {
                        if (userType == "customer") {
                          Navigator.of(context).pushNamed(CustomerRegisterScreen.routeName);
                        } else {
                          Navigator.of(context).pushNamed(TechnicianRegisterScreen.routeName);
                        }
                      },
                      text: AppLocalizations.of(context)!.create_account,
                    )
                  ],
                ),
                SizedBox(height: height * 0.02),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'حسابات الاختبار (للتجربة فقط):',
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'عميل: customer@test.com\nكلمة المرور: password123',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'فني: tech@test.com\nكلمة المرور: password123',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> login() async {
    if (formKey.currentState?.validate() != true) return;

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    bool hasInternet = await _checkInternetConnection();
    if (!mounted) return;

    if (!hasInternet) {
      messenger.showSnackBar(
        SnackBar(
          content: const Text('لا يوجد اتصال بالإنترنت. يرجى التحقق من الشبكة والمحاولة مرة أخرى.'),
          backgroundColor: Colors.red[600],
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: 'إغلاق',
            textColor: Colors.white,
            onPressed: () => messenger.hideCurrentSnackBar(),
          ),
        ),
      );
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final result = await _authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      final user = result.$1;
      final token = result.$2;

      ApiClient().setAuthToken(token);

      userProvider.setUser(
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
        phone: user.phone,
        profileImage: user.profileImage,
        token: token,
      );

      navigator.pop(); // close loader

      messenger.showSnackBar(
        SnackBar(
          content: Text('Login successful! Welcome back, ${user.name}'),
          backgroundColor: Colors.green[600],
          duration: const Duration(seconds: 3),
        ),
      );

      if (userProvider.isTechnician()) {
        navigator.pushReplacementNamed(TechnicianShell.routeName);
      } else {
        navigator.pushReplacementNamed(CustomerShell.routeName);
      }
    } catch (e) {
      if (!mounted) return;
      navigator.pop(); // close loader

      String errorMessage = 'Login failed';
      String errorString = e.toString().toLowerCase();

      if (errorString.contains('email') || errorString.contains('password') || errorString.contains('credentials')) {
        errorMessage = 'البريد الإلكتروني أو كلمة المرور غير صحيحة. يرجى التحقق من البيانات والمحاولة مرة أخرى.';
      } else if (errorString.contains('network') || errorString.contains('connection') || errorString.contains('socket')) {
        errorMessage = 'مشكلة في الاتصال بالشبكة. يرجى التحقق من اتصال الإنترنت والمحاولة مرة أخرى.';
      } else if (errorString.contains('not found') || errorString.contains('user')) {
        errorMessage = 'المستخدم غير موجود. يرجى التحقق من البريد الإلكتروني أو إنشاء حساب جديد.';
      } else if (errorString.contains('blocked') || errorString.contains('suspended')) {
        errorMessage = 'تم تعليق حسابك. يرجى التواصل مع الدعم الفني.';
      } else if (errorString.contains('timeout')) {
        errorMessage = 'استغرق الوقت. يرجى المحاولة مرة أخرى.';
      } else if (errorString.contains('server') || errorString.contains('500')) {
        errorMessage = 'مشكلة في الخادم. يرجى المحاولة لاحقاً.';
      } else {
        errorMessage = 'حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى. كود الخطأ: $errorString';
      }

      messenger.showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red[600],
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'إغلاق',
            textColor: Colors.white,
            onPressed: () => messenger.hideCurrentSnackBar(),
          ),
        ),
      );
    }
  }

  void forgetPassword() {}
}
