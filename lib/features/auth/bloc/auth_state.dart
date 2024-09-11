part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoginSuccess extends AuthState {
  final String name;
  AuthLoginSuccess({required this.name});
}

final class AuthFailed extends AuthState {
  final String e;
  AuthFailed(this.e);
}
