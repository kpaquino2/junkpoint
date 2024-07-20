part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String credential;
  final String name;
  final String password;
  final String role;

  AuthSignUp({
    required this.credential,
    required this.name,
    required this.password,
    required this.role,
  });
}

final class AuthLogIn extends AuthEvent {
  final String email;
  final String password;

  AuthLogIn({
    required this.email,
    required this.password,
  });
}

final class AuthIsUserLoggedIn extends AuthEvent {}

final class AuthLogOut extends AuthEvent {}
