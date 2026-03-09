import '../../domain/auth_entity.dart';
import '../models/auth_models.dart';

extension UserDtoMapper on UserDto {
  AuthUser toEntity() => AuthUser(id: id, email: email, name: name, phone: phone);
}

extension AuthResponseDtoMapper on AuthResponseDto {
  AuthSessionEntity toEntity() => AuthSessionEntity(
    accessToken: accessToken,
    refreshToken: refreshToken,
    user: user.toEntity(),
  );
}
