class AuthUser {
  final String id;
  final String? email;
  final String? phone;
  final String role;

  const AuthUser({
    required this.id,
    required this.role,
    this.email,
    this.phone,
  });
}

