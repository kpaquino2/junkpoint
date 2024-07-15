import 'package:get_it/get_it.dart';
import 'package:junkpoint/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:junkpoint/core/secrets/app_secrets.dart';
import 'package:junkpoint/features/auth/data/auth_remote_data_source.dart';
import 'package:junkpoint/features/auth/data/auth_repository_impl.dart';
import 'package:junkpoint/features/auth/domain/repository/auth_repository.dart';
import 'package:junkpoint/features/auth/domain/usecases/current_user.dart';
import 'package:junkpoint/features/auth/domain/usecases/user_login.dart';
import 'package:junkpoint/features/auth/domain/usecases/user_logout.dart';
import 'package:junkpoint/features/auth/domain/usecases/user_sign_up.dart';
import 'package:junkpoint/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserLogIn(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => CurrentUser(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserLogOut(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogIn: serviceLocator(),
      currentUser: serviceLocator(),
      userLogOut: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}
