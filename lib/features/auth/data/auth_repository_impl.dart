import 'package:fpdart/fpdart.dart';
import 'package:junkpoint/core/error/exceptions.dart';
import 'package:junkpoint/core/error/failure.dart';
import 'package:junkpoint/features/auth/data/auth_remote_data_source.dart';
import 'package:junkpoint/features/auth/domain/entities/client.dart';
import 'package:junkpoint/features/auth/domain/entities/shop.dart';
import 'package:junkpoint/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> logInWithEmailPassword(
      {required String email, required String password}) {
    // TODO: implement logInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Either<Client, Shop>>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final user = await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
        role: role,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
