import 'dart:convert';

import 'package:ecom_front/core/network/query/query_builders.dart';
import 'package:ecom_front/core/utils/result.dart';
import 'package:ecom_front/features/admin/domain/admin_entity.dart';
import 'package:ecom_front/features/admin/domain/admin_repository.dart';
import 'package:ecom_front/features/auth/domain/auth_entity.dart';
import 'package:ecom_front/features/auth/domain/auth_repository.dart';
import 'package:ecom_front/features/cart/domain/cart_entity.dart';
import 'package:ecom_front/features/cart/domain/cart_repository.dart';
import 'dart:io';

class MockAuthRepository implements AuthRepository {
  bool loggedIn = false;

  @override
  Future<Result<AuthSessionEntity>> login({required String email, required String password}) async {
    final raw = await File('test/fixtures/auth_session.json').readAsString();
    final payload = jsonDecode(raw) as Map<String, dynamic>;
    loggedIn = true;
    return Success(
      AuthSessionEntity(
        accessToken: payload['accessToken'].toString(),
        refreshToken: payload['refreshToken'].toString(),
        user: AuthUser(
          id: 'test-user-id',
          email: payload['email']?.toString() ?? email,
          name: payload['name']?.toString() ?? 'Test User',
          phone: payload['phone']?.toString(),
        ),
      ),
    );
  }

  @override
  Future<Result<void>> logout() async {
    loggedIn = false;
    return const Success(null);
  }

  @override
  Future<Result<AuthSessionEntity>> refresh({required String refreshToken}) =>
      Future.value(Failure('Not used in test'));

  @override
  Future<Result<AuthSessionEntity>> register({required String email, required String password, required String name}) =>
      Future.value(Failure('Not used in test'));

  @override
  Future<Result<AuthUser>> getMe() => Future.value(Failure('Not used in test'));

  @override
  Future<Result<AuthUser>> updateProfile({String? name, String? phone}) => Future.value(Failure('Not used in test'));

  @override
  Future<List<AuthEntity>> getAll() async => const [];
}

class MockCartRepository implements CartRepository {
  @override
  Future<Result<CartAggregateEntity>> create({required String userId}) =>
      Future.value(Failure('Not used in test'));

  @override
  Future<Result<CartAggregateEntity>> get(String cartId) =>
      Future.value(Failure('Not used in test'));

  @override
  Future<List<CartEntity>> getAll() async => const [];

  @override
  Future<Result<CartAggregateEntity>> updateItem({required String cartId, required String productId, required int quantity}) =>
      Future.value(Failure('Not used in test'));
}

class MockAdminRepository implements AdminRepository {
  @override
  Future<Result<List<AdminItemEntity>>> bulk({required List<String> ids, required String action}) =>
      Future.value(Failure('Not used in test'));

  @override
  Future<Result<AdminItemEntity>> create(AdminItemEntity item) =>
      Future.value(Failure('Not used in test'));

  @override
  Future<Result<void>> delete(String id) => Future.value(Failure('Not used in test'));

  @override
  Future<List<AdminEntity>> getAll() async => const [];

  @override
  Future<Result<int>> import({required String source, required String format}) =>
      Future.value(Failure('Not used in test'));

  @override
  Future<Result<PageResponse<AdminItemEntity>>> list(PageRequest request) =>
      Future.value(Failure('Not used in test'));

  @override
  Future<Result<AdminItemEntity>> read(String id) => Future.value(Failure('Not used in test'));

  @override
  Future<Result<List<AdminReportEntity>>> reports(PageRequest request) =>
      Future.value(Failure('Not used in test'));

  @override
  Future<Result<AdminItemEntity>> update(AdminItemEntity item) =>
      Future.value(Failure('Not used in test'));
}
