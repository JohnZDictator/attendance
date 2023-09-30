import 'package:attendance/core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../features.dart';

class LogoutUsecase extends UseCase<void, NoParams> {
  LogoutUsecase({
    required this.repository,
  });

  final AuthenticationRepository repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.logout();
  }
}
