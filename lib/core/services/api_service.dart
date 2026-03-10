import 'package:app/core/services/rating_service.dart';
import 'package:app/core/services/service_request_service.dart';
import 'package:app/core/services/technician_service.dart';

import 'auth_service.dart';
import 'complaint_service.dart';
import 'customer_service.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final AuthService auth = AuthService();
  final CustomerService customer = CustomerService();
  final TechnicianService technician = TechnicianService();
  final ComplaintService complaint = ComplaintService();
  final ServiceRequestService serviceRequest = ServiceRequestService();
  final RatingService rating = RatingService();
}
