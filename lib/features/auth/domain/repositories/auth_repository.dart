import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<(UserEntity user, String? token)> login({
    required String email,
    required String password,
  });

  Future<(UserEntity user, String? token)> registerCustomer({
    required String name,
    required String email,
    required String phone,
    required String password,
  });

  Future<(UserEntity user, String? token)> registerTechnician({
    required String name,
    required String email,
    required String phone,
    required String password,
  });
}

