import 'package:zolver/features/auth/domain/entities/auth_user.dart';
import 'package:zolver/features/auth/domain/repositories/auth_repository.dart';

class LoginWithPhone {
  final AuthRepository _repository;

  const LoginWithPhone(this._repository);

  Future<AuthUser> call({
    required String phone,
    required String role,
  }) {
    return _repository.loginWithPhone(phone: phone, role: role);
  }
}

