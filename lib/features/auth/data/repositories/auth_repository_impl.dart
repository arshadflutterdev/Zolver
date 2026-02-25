import 'package:zolver/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:zolver/features/auth/domain/entities/auth_user.dart';
import 'package:zolver/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;

  const AuthRepositoryImpl(this._remote);

  @override
  Future<AuthUser> loginWithEmail({
    required String email,
    required String role,
  }) {
    return _remote.loginWithEmail(email: email, role: role);
  }

  @override
  Future<AuthUser> loginWithPhone({
    required String phone,
    required String role,
  }) {
    return _remote.loginWithPhone(phone: phone, role: role);
  }
}

