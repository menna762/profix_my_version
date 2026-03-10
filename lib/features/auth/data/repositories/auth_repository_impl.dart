import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/auth_response_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  (UserEntity user, String? token) _mapResponse(AuthResponseModel response) {
    return (response.user, response.token);
  }

  @override
  Future<(UserEntity user, String? token)> login({
    required String email,
    required String password,
  }) async {
    final res = await _remoteDataSource.login(email: email, password: password);
    return _mapResponse(res);
  }

  @override
  Future<(UserEntity user, String? token)> registerCustomer({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final res = await _remoteDataSource.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
      role: 'customer',
    );
    return _mapResponse(res);
  }

  @override
  Future<(UserEntity user, String? token)> registerTechnician({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final res = await _remoteDataSource.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
      role: 'technician',
    );
    return _mapResponse(res);
  }
}

