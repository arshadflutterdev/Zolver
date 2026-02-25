import 'dart:async';

import 'package:zolver/features/auth/data/models/auth_user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserModel> loginWithEmail({
    required String email,
    required String role,
  });

  Future<AuthUserModel> loginWithPhone({
    required String phone,
    required String role,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<AuthUserModel> loginWithEmail({
    required String email,
    required String role,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return AuthUserModel(
      id: 'mock-email-user',
      email: email,
      role: role,
    );
  }

  @override
  Future<AuthUserModel> loginWithPhone({
    required String phone,
    required String role,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return AuthUserModel(
      id: 'mock-phone-user',
      phone: phone,
      role: role,
    );
  }
}

