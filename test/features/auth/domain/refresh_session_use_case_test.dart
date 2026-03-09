import 'package:ecom_front/core/utils/result.dart';
import 'package:ecom_front/features/auth/domain/auth_entity.dart';
import 'package:ecom_front/features/auth/domain/auth_repository.dart';
import 'package:ecom_front/features/auth/domain/auth_use_cases.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAuthRepository implements AuthRepository {
  String? lastRefreshToken;

  @override
  Future<Result<AuthSessionEntity>> refresh({required String refreshToken}) async {
    lastRefreshToken = refreshToken;
    return const Success(
      AuthSessionEntity(
        accessToken: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidHlwZSI6ImFjY2VzcyIsImp0aSI6ImEyODgxMmZjLTc3MzktNDE4Mi05YjYxLTI4M2QxNjRiNDJhMyIsImlhdCI6MTc3MzA3MjY1MiwiZXhwIjoxNzczMDczNTUyLCJyb2xlIjoiYWRtaW4ifQ.gbdN7c8Hw7zMQlLnQiZ0XN0TXOs-rLACYekKzoyH4bw',
        refreshToken: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwidHlwZSI6InJlZnJlc2giLCJqdGkiOiIyMzgzOWFjMC1iMDE2LTRlZmUtYjE5MS02YWU3NjgyZTBlMjgiLCJpYXQiOjE3NzMwNzI2NTIsImV4cCI6MTc3NTY2NDY1Miwic2lkIjo2fQ.mvgr_Z2JZHEfezvYDuvxXEKhw7PBxK8rqoYQZTXP14I',
        user: AuthUser(id: '1', email: 'user@example.com', name: 'User'),
      ),
    );
  }

  @override
  Future<List<AuthEntity>> getAll() async => const [];

  @override
  Future<Result<AuthUser>> getMe() async => const Failure('unused');

  @override
  Future<Result<AuthSessionEntity>> login({required String email, required String password}) async => const Failure('unused');

  @override
  Future<Result<void>> logout() async => const Success(null);

  @override
  Future<Result<AuthSessionEntity>> register({required String email, required String password, required String name}) async =>
      const Failure('unused');

  @override
  Future<Result<AuthUser>> updateProfile({String? name, String? phone}) async => const Failure('unused');
}

void main() {
  test('RefreshSessionUseCase delegates to repository', () async {
    final repo = _FakeAuthRepository();
    final useCase = RefreshSessionUseCase(repo);

    final result = await useCase.call('refresh-1');

    expect(repo.lastRefreshToken, 'refresh-1');
    expect(result, isA<Success<AuthSessionEntity>>());
  });
}
