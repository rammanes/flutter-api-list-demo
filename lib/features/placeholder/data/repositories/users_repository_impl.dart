import 'package:vsi_assessment/features/placeholder/domain/entities/user.dart';
import 'package:vsi_assessment/features/placeholder/domain/repositories/users_repository.dart';

import '../datasources/user_api_service.dart';

class UsersRepositoryImpl implements UsersRepository {
  UsersRepositoryImpl({UserApiService? apiService})
      : _apiService = apiService ?? UserApiService();

  final UserApiService _apiService;

  @override
  Future<List<User>> getUsers() => _apiService.fetchUsers();

  @override
  Future<User?> getUserById(int id) => _apiService.fetchUserById(id);
}
