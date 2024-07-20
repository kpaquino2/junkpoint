import 'package:fpdart/fpdart.dart';
import 'package:junkpoint/core/error/failure.dart';
import 'package:junkpoint/core/common/entities/client.dart';
import 'package:junkpoint/core/common/entities/shop.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Either<Client, Shop>>> signUpWithEmailPassword({
    required String name,
    required String credential,
    required String password,
    required String role,
  });

  Future<Either<Failure, Either<Client, Shop>>> logInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, Either<Client, Shop>>> currentUser();

  Future<void> logOut();
}
