part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String name;
  final String password;
  final String role;

  AuthSignUp({
    required this.email,
    required this.name,
    required this.password,
    required this.role,
  });
}
