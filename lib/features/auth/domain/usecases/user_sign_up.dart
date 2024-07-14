import 'package:fpdart/fpdart.dart';
import 'package:junkpoint/core/error/failure.dart';
import 'package:junkpoint/core/usercase/usecase.dart';
import 'package:junkpoint/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<String, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
      role: params.role,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;
  final String role;

  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name,
    required this.role,
  });
}
