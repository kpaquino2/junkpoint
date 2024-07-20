import 'package:fpdart/fpdart.dart';
import 'package:junkpoint/core/error/exceptions.dart';
import 'package:junkpoint/core/error/failure.dart';
import 'package:junkpoint/features/auth/data/auth_remote_data_source.dart';
import 'package:junkpoint/core/common/entities/client.dart';
import 'package:junkpoint/core/common/entities/shop.dart';
import 'package:junkpoint/features/auth/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Either<Client, Shop>>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) return left(Failure('User not logged in'));
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Either<Client, Shop>>> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, Either<Client, Shop>>> signUpWithEmailPassword({
    required String name,
    required String credential,
    required String password,
    required String role,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailPassword(
        name: name,
        credential: credential,
        password: password,
        role: role,
      ),
    );
  }

  Future<Either<Failure, Either<Client, Shop>>> _getUser(
    Future<Either<Client, Shop>> Function() fn,
  ) async {
    try {
      final user = await fn();
      return right(user);
    } on AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<void> logOut() async {
    await remoteDataSource.logOut();
  }
}
