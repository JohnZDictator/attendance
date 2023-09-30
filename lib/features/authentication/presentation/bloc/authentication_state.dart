part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

enum AuthenticationStatus { loading, loaded, error }

class LoginState extends AuthenticationState {
  const LoginState({
    required this.status,
    this.user,
    this.errorMessage,
  });

  final User? user;
  final String? errorMessage;
  final AuthenticationStatus status;

  @override
  List<Object?> get props => [user, errorMessage, status];
}

class LogoutState extends AuthenticationState {
  const LogoutState({
    required this.status,
    this.errorMessage,
  });

  final AuthenticationStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, errorMessage];
}

class FetchEventState extends AuthenticationState {
  const FetchEventState({
    required this.status,
    this.event,
    this.errorMessage,
  });

  final Event? event;
  final AuthenticationStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [event, status, errorMessage];
}
