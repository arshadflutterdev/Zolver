import 'package:zolver/features/auth/domain/entities/auth_user.dart';
import 'package:zolver/features/auth/domain/repositories/auth_repository.dart';

class LoginWithEmail {
  final AuthRepository _repository;

  const LoginWithEmail(this._repository);

  Future<AuthUser> call({
    required String email,
    required String role,
  }) {
    return _repository.loginWithEmail(email: email, role: role);
  }
}

