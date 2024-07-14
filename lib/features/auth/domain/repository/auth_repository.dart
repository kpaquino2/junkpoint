import 'package:fpdart/fpdart.dart';
import 'package:junkpoint/core/error/failure.dart';
import 'package:junkpoint/features/auth/domain/entities/client.dart';
import 'package:junkpoint/features/auth/domain/entities/shop.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Either<Client, Shop>>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
    required String role,
  });

  Future<Either<Failure, String>> logInWithEmailPassword({
    required String email,
    required String password,
  });
}
