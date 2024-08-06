import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String surname;

  const SignUpRequested(
      this.email, this.password, this.firstName, this.surname);

  @override
  List<Object> get props => [email, password, firstName, surname];
}

class GoogleSignInRequested extends AuthEvent {}

class GetCurrentUserRequested extends AuthEvent {}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {}

class LoggedOut extends AuthEvent {}
