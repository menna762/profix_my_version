import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';

class AuthService {
  AuthService({Dio? dio}) : _dio = dio ?? ApiClient().client;

  final Dio _dio;

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    final response = await _dio.post(
      '/auth/register',
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'role': role,
      },
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getMe() async {
    final response = await _dio.get('/auth/me');
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateUser(String id, Map<String, dynamic> data, {String? imagePath}) async {
    FormData formData;
    
    if (imagePath != null) {
      formData = FormData.fromMap({
        ...data,
        'profileImage': await MultipartFile.fromFile(imagePath),
      });
    } else {
      formData = FormData.fromMap(data);
    }

    final response = await _dio.patch('/auth/update/$id', data: formData);
    
    // If image was uploaded, extract the URL from response
    if (response.data['profileImage'] != null) {
      response.data['profileImage'] = response.data['profileImage'];
    }
    
    return response.data as Map<String, dynamic>;
  }

  Future<void> logout() async {
    await _dio.get('/auth/logout');
  }
}
