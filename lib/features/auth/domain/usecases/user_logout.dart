import 'package:junkpoint/features/auth/domain/repository/auth_repository.dart';

class UserLogOut {
  final AuthRepository authRepository;
  const UserLogOut(this.authRepository);

  Future<void> call() async {
    await authRepository.logOut();
  }
}
