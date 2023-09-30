import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class NetworkFailure extends Failure {}

class ServerFailure extends Failure {}

class LogoutFailure extends Failure {}

class UserNotFoundFailure extends Failure {}

class EventNotFoundFailure extends Failure {}
