import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class RegisterRequestDto {
  const RegisterRequestDto({required this.email, required this.password, required this.name});

  final String email;
  final String password;
  final String name;

  Map<String, dynamic> toJson() => {'email': email, 'password': password, 'name': name};
}

@JsonSerializable()
class LoginRequestDto {
  const LoginRequestDto({required this.email, required this.password});

  final String email;
  final String password;

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

@JsonSerializable()
class RefreshRequestDto {
  const RefreshRequestDto({required this.refreshToken});

  final String refreshToken;

  Map<String, dynamic> toJson() => {'refresh_token': refreshToken};
}

@JsonSerializable()
class UpdateProfileRequestDto {
  const UpdateProfileRequestDto({this.name, this.phone});

  final String? name;
  final String? phone;

  Map<String, dynamic> toJson() => {'name': name, 'phone': phone};
}

@JsonSerializable()
class AuthResponseDto {
  const AuthResponseDto({required this.accessToken, required this.refreshToken, required this.user});

  final String accessToken;
  final String refreshToken;
  final UserDto user;

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) => AuthResponseDto(
    accessToken: json['access_token'] as String? ?? '',
    refreshToken: json['refresh_token'] as String? ?? '',
    user: UserDto.fromJson(Map<String, dynamic>.from(json['user'] as Map? ?? const {})),
  );
}

@JsonSerializable()
class UserDto {
  const UserDto({required this.id, required this.email, required this.name, this.phone});

  final String id;
  final String email;
  final String name;
  final String? phone;

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
    id: json['id']?.toString() ?? '',
    email: json['email']?.toString() ?? '',
    name: json['name']?.toString() ?? '',
    phone: json['phone']?.toString(),
  );
}
