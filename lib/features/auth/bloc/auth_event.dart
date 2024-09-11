part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthenticationUserEvent extends AuthEvent {}

class AuthLogin extends AuthEvent {
  final String username, password;
  AuthLogin(this.username, this.password);
}

class AuthLogout extends AuthEvent {}
