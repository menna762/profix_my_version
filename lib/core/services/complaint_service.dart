import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';

class ComplaintService {
  ComplaintService({Dio? dio}) : _dio = dio ?? ApiClient().client;

  final Dio _dio;

  Future<Map<String, dynamic>> createComplaint(Map<String, dynamic> complaintData) async {
    final response = await _dio.post('/complaints/add', data: complaintData);
    return response.data as Map<String, dynamic>;
  }

  Future<List<dynamic>> getAllComplaints() async {
    final response = await _dio.get('/complaints');
    return response.data as List<dynamic>;
  }

  Future<Map<String, dynamic>> getComplaint(String id) async {
    final response = await _dio.get('/complaints/$id');
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateComplaintStatus(String id, String status) async {
    final response = await _dio.patch('/complaints/$id/status', data: {'status': status});
    return response.data as Map<String, dynamic>;
  }

  Future<void> deleteComplaint(String id) async {
    await _dio.delete('/complaints/$id');
  }
}
