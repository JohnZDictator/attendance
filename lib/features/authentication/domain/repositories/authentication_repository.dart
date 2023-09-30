import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, Event>> fetchEvent();
  Future<Either<Failure, User>> fetchUser();
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, Unit>> logout();
}
