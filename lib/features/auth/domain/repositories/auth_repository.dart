import 'package:zolver/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> loginWithEmail({
    required String email,
    required String role,
  });

  Future<AuthUser> loginWithPhone({
    required String phone,
    required String role,
  });
}

