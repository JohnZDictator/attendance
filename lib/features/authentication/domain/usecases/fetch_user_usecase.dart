import 'package:attendance/core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../features.dart';

class FetchUserUsecase extends UseCase<User, NoParams> {
  FetchUserUsecase({
    required this.repository,
  });

  final AuthenticationRepository repository;

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.fetchUser();
  }
}
