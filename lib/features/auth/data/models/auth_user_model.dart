import 'package:zolver/features/auth/domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  const AuthUserModel({
    required super.id,
    required super.role,
    super.email,
    super.phone,
  });
}

