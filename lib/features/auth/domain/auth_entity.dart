class AuthUser {
  const AuthUser({required this.id, required this.email, required this.name, this.phone});

  final String id;
  final String email;
  final String name;
  final String? phone;
}

class AuthSessionEntity {
  const AuthSessionEntity({required this.accessToken, required this.refreshToken, required this.user});

  final String accessToken;
  final String refreshToken;
  final AuthUser user;
}

class AuthEntity extends AuthUser {
  const AuthEntity({required super.id, required super.email, required super.name, super.phone});
}
