import 'package:attendance/core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../features.dart';

class FetchEventUsecase extends UseCase<Event, NoParams> {
  FetchEventUsecase({
    required this.repository,
  });

  final AuthenticationRepository repository;

  @override
  Future<Either<Failure, Event>> call(NoParams params) async {
    return await repository.fetchEvent();
  }
}
