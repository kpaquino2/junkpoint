import 'package:fpdart/fpdart.dart';
import 'package:junkpoint/core/error/failure.dart';
import 'package:junkpoint/core/usercase/usecase.dart';
import 'package:junkpoint/core/common/entities/client.dart';
import 'package:junkpoint/core/common/entities/shop.dart';
import 'package:junkpoint/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<Either<Client, Shop>, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, Either<Client, Shop>>> call(params) async {
    return await authRepository.currentUser();
  }
}
