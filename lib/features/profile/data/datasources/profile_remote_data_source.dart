import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
//import '../../../core/network/api_client.dart';

class ProfileRemoteDataSource {
  ProfileRemoteDataSource({Dio? dio}) : _dio = dio ?? ApiClient().client;

  final Dio _dio;

  Future<Map<String, dynamic>> getMe() async {
    final res = await _dio.get('/auth/me');
    return res.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getCustomerProfile(String userId) async {
    final res = await _dio.get('/customers/$userId');
    return res.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getTechnicianProfile(String userId) async {
    final res = await _dio.get('/technicians/$userId');
    return res.data as Map<String, dynamic>;
  }
}

