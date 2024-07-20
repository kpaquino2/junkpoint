import 'package:fpdart/fpdart.dart';
import 'package:junkpoint/core/error/failure.dart';
import 'package:junkpoint/core/usercase/usecase.dart';
import 'package:junkpoint/core/common/entities/client.dart';
import 'package:junkpoint/core/common/entities/shop.dart';
import 'package:junkpoint/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<Either<Client, Shop>, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, Either<Client, Shop>>> call(
      UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      credential: params.credential,
      password: params.password,
      role: params.role,
    );
  }
}

class UserSignUpParams {
  final String credential;
  final String password;
  final String name;
  final String role;

  UserSignUpParams({
    required this.credential,
    required this.password,
    required this.name,
    required this.role,
  });
}
