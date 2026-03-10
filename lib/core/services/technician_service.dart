import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';

class TechnicianService {
  TechnicianService({Dio? dio}) : _dio = dio ?? ApiClient().client;

  final Dio _dio;

  Future<List<dynamic>> getAllTechnicians() async {
    final response = await _dio.get('/technicians');
    return response.data as List<dynamic>;
  }

  Future<Map<String, dynamic>> getTechnicianProfile(String id) async {
    final response = await _dio.get('/technicians/$id');
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateTechnicianProfile(String id, Map<String, dynamic> data) async {
    final response = await _dio.patch('/technicians/$id', data: data);
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateTechnicianStatus(String id, String status) async {
    final response = await _dio.patch('/technicians/$id/status', data: {'status': status});
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getTechnicianStats(String id) async {
    final response = await _dio.get('/technicians/$id/stats');
    return response.data as Map<String, dynamic>;
  }

  Future<void> deleteTechnician(String id) async {
    await _dio.delete('/technicians/delete/$id');
  }

  Future<Map<String, dynamic>> updateServiceAreas(String technicianId, List<Map<String, dynamic>> areas) async {
    final response = await _dio.patch(
      '/technicians/$technicianId',
      data: {'serviceAreas': areas},
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateServiceCategories(String technicianId, List<String> categories) async {
    // تم التعديل لاستخدام 'specializations' لأن هذا هو المسمى المعرف في الموديل في السيرفر
    final response = await _dio.patch(
      '/technicians/$technicianId', 
      data: {'specializations': categories},
    );
    return response.data as Map<String, dynamic>;
  }
}
