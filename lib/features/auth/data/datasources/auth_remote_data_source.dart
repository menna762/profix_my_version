import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({Dio? dio})
      : _dio = dio ?? ApiClient().client;

  final Dio _dio;

  // Mock user data for development
  final Map<String, Map<String, dynamic>> _mockUsers = {
    'customer@test.com': {
      'id': '1',
      'name': 'Ahmed Customer',
      'email': 'customer@test.com',
      'phone': '+201234567890',
      'password': 'password123',
      'role': 'customer',
      'profileImage': null,
    },
    'tech@test.com': {
      'id': '2',
      'name': 'Mohamed Technician',
      'email': 'tech@test.com',
      'phone': '+201987654321',
      'password': 'password123',
      'role': 'technician',
      'profileImage': null,
    },
  };

  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Check mock users first
    final mockUser = _mockUsers[email];
    if (mockUser != null && mockUser['password'] == password) {
      final user = UserModel(
        id: mockUser['id']!,
        name: mockUser['name']!,
        email: mockUser['email']!,
        phone: mockUser['phone']!,
        role: mockUser['role']!,
        profileImage: mockUser['profileImage'],
      );
      
      return AuthResponseModel.direct(
        success: true,
        user: user,
        token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
      );
    }
    
    // Try real API if mock fails
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      
      final responseData = response.data as Map<String, dynamic>;
      
      if (responseData.containsKey('user') && responseData.containsKey('token')) {
        return AuthResponseModel.fromJson(responseData);
      } else if (responseData.containsKey('success') && responseData['success'] == true) {
        final token = responseData['token'] as String;
        final cleanToken = token.replaceFirst('Bearer ', '');
        
        return AuthResponseModel.direct(
          success: true,
          user: UserModel.fromJson(responseData['user'] as Map<String, dynamic>),
          token: cleanToken,
        );
      } else {
        throw Exception('Invalid response format from server');
      }
    } catch (e) {
      // If real API fails, throw authentication error
      throw Exception('Invalid email or password. Try: customer@test.com / tech@test.com with password: password123');
    }
  }

  Future<AuthResponseModel> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Check if email already exists in mock data
    if (_mockUsers.containsKey(email)) {
      throw Exception('Email already exists');
    }
    
    // Create new mock user
    final newUserId = (_mockUsers.length + 1).toString();
    final newUser = UserModel(
      id: newUserId,
      name: name,
      email: email,
      phone: phone,
      role: role,
      profileImage: null,
    );
    
    // Add to mock users
    _mockUsers[email] = {
      'id': newUserId,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
      'profileImage': null,
    };
    
    return AuthResponseModel.direct(
      success: true,
      user: newUser,
      token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
    );
  }
}

