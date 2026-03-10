import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';

class CustomerService {
  CustomerService({Dio? dio}) : _dio = dio ?? ApiClient().client;

  final Dio _dio;

  Future<Map<String, dynamic>> getCustomerProfile(String id) async {
    final response = await _dio.get('/customers/$id');
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateCustomerProfile(String id, Map<String, dynamic> data) async {
    final response = await _dio.patch('/customers/$id', data: data);
    return response.data as Map<String, dynamic>;
  }

  Future<List<dynamic>> getAllCustomers() async {
    final response = await _dio.get('/customers');
    return response.data as List<dynamic>;
  }

  Future<void> deleteCustomer(String id) async {
    await _dio.delete('/customers/delete/$id');
  }
}
