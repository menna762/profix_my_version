import 'package:flutter/material.dart';

// بنعرف Enum عشان الكود يكون مقروء وسهل (عميل أو فني)
enum UserRole { customer, technician }

class UserProvider extends ChangeNotifier {
  // القيمة الافتراضية هنخليها عميل
  UserRole _role = UserRole.customer;

  String? _token;
  String? _id;
  String? _name;
  String? _email;
  String? _phone;
  String? _profileImage;
  double? _rate;
  int? _totalJobs;

  UserRole get role => _role;
  String? get token => _token;
  String? get id => _id;
  String? get userId => _id;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get profileImage => _profileImage;
  double? get rate => _rate;
  int? get totalJobs => _totalJobs;

  // دالة لتحديث بيانات المستخدم بعد الـ Login / Register
  void setUser({
    required String id,
    required String name,
    required String email,
    required String role,
    String? phone,
    String? token,
    String? profileImage,
    double? rate,
    int? totalJobs,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _phone = phone;
    _token = token;
    _profileImage = profileImage;
    _rate = rate;
    _totalJobs = totalJobs;
    _role = role == 'technician' ? UserRole.technician : UserRole.customer;
    notifyListeners();
  }

  // دالة لتغيير نوع المستخدم (هنناديها وقت اختيار الـ Role من الـ UI)
  void setUserRole(UserRole newRole) {
    _role = newRole;
    notifyListeners(); // دي اللي بتخلي الصفحات تحس بالتغيير
  }

  // دالة مساعدة عشان نعرف هو فني ولا لأ بسهولة
  bool isTechnician() => _role == UserRole.technician;

  void clear() {
    _token = null;
    _id = null;
    _name = null;
    _email = null;
    _phone = null;
    _profileImage = null;
    _rate = null;
    _totalJobs = null;
    _role = UserRole.customer;
    notifyListeners();
  }

  // Method to update user profile data
  void updateProfile({
    String? name,
    String? phone,
    String? profileImage,
    double? rate,
    int? totalJobs,
  }) {
    if (name != null) _name = name;
    if (phone != null) _phone = phone;
    if (profileImage != null) _profileImage = profileImage;
    if (rate != null) _rate = rate;
    if (totalJobs != null) _totalJobs = totalJobs;
    notifyListeners();
  }
}
