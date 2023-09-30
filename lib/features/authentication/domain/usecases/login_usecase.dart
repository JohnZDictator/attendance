import 'package:attendance/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../features.dart';

class LoginUsecase extends UseCase<User, LoginParams> {
  LoginUsecase({
    required this.repository,
  });

  final AuthenticationRepository repository;

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams extends Equatable {
  const LoginParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
