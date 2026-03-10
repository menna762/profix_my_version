import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';

class RatingService {
  RatingService({Dio? dio}) : _dio = dio ?? ApiClient().client;

  final Dio _dio;

  Future<Map<String, dynamic>> createRating(Map<String, dynamic> ratingData) async {
    final response = await _dio.post('/rating/add', data: ratingData);
    return response.data as Map<String, dynamic>;
  }

  Future<List<dynamic>> getTechnicianRatings(String technicianId) async {
    final response = await _dio.get('/rating/get-technician-rate/$technicianId');
    return response.data as List<dynamic>;
  }

  Future<Map<String, dynamic>> getRating(String id) async {
    final response = await _dio.get('/rating/$id');
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateRating(String id, Map<String, dynamic> ratingData) async {
    final response = await _dio.patch('/rating/$id', data: ratingData);
    return response.data as Map<String, dynamic>;
  }

  Future<void> deleteRating(String id) async {
    await _dio.delete('/rating/$id');
  }
}
