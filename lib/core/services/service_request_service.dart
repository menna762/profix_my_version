import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';

class ServiceRequestService {
  ServiceRequestService({Dio? dio}) : _dio = dio ?? ApiClient().client;

  final Dio _dio;

  Future<Map<String, dynamic>> createServiceRequest(Map<String, dynamic> requestData, {String? imagePath}) async {
    FormData formData;
    
    if (imagePath != null) {
      formData = FormData.fromMap({
        ...requestData,
        'image': await MultipartFile.fromFile(imagePath),
      });
    } else {
      formData = FormData.fromMap(requestData);
    }

    final response = await _dio.post('/requests/add', data: formData);
    return response.data as Map<String, dynamic>;
  }

  Future<List<dynamic>> getAllServiceRequests() async {
    final response = await _dio.get('/requests/all');
    return response.data as List<dynamic>;
  }

  Future<Map<String, dynamic>> getServiceRequest(String id) async {
    final response = await _dio.get('/requests/$id');
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> assignTechnician(String id, String technicianId) async {
    final response = await _dio.patch('/requests/$id/assign', data: {'technicianId': technicianId});
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateServiceRequestStatus(String id, String status) async {
    final response = await _dio.patch('/requests/$id/status', data: {'status': status});
    return response.data as Map<String, dynamic>;
  }

  Future<void> deleteServiceRequest(String id) async {
    await _dio.delete('/requests/$id');
  }
}
