import 'package:fpdart/fpdart.dart';
import 'package:junkpoint/core/error/failure.dart';
import 'package:junkpoint/core/usercase/usecase.dart';
import 'package:junkpoint/core/common/entities/client.dart';
import 'package:junkpoint/core/common/entities/shop.dart';
import 'package:junkpoint/features/auth/domain/repository/auth_repository.dart';

class UserLogIn implements UseCase<Either<Client, Shop>, UserLogInParams> {
  final AuthRepository authRepository;
  const UserLogIn(this.authRepository);

  @override
  Future<Either<Failure, Either<Client, Shop>>> call(
      UserLogInParams params) async {
    return await authRepository.logInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLogInParams {
  final String email;
  final String password;

  UserLogInParams({required this.email, required this.password});
}
