import 'package:fpdart/fpdart.dart';
import 'package:junkpoint/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmailPassword({
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
