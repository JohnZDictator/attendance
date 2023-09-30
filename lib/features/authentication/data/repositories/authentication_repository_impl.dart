import 'package:attendance/core/core.dart';
import 'package:attendance/features/features.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  AuthenticationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final AuthenticationRemoteDataSource remoteDataSource;
  final AuthenticationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Event>> fetchEvent() async {
    if (await networkInfo.isConnected) {
      try {
        final event = await remoteDataSource.fetchEvent();
        await localDataSource.cacheEvent(event);
        return Right(event);
      } on EventNotFoundException {
        return Left(EventNotFoundFailure());
      }
    } else {
      try {
        final event = await localDataSource.fetchEvent();
        return Right(event);
      } on EventNotFoundException {
        return Left(EventNotFoundFailure());
      }
    }
  }

  @override
  Future<Either<Failure, User>> fetchUser() async {
    try {
      final user = await localDataSource.fetchUser();
      return Right(user);
    } on UserNotFoundException {
      return Left(UserNotFoundFailure());
    }
  }

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.login(
          email: email,
          password: password,
        );
        // final event = await remoteDataSource.fetchEvent();
        // await localDataSource.cacheEvent(event);
        return Right(user);
      } on UserNotFoundException {
        return Left(UserNotFoundFailure());
      } on EventNotFoundException {
        return Left(EventNotFoundFailure());
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await localDataSource.logout();
      await localDataSource.clearEvent();
      return const Right(unit);
    } on LogoutException {
      return Left(LogoutFailure());
    } on EventNotFoundException {
      return Left(EventNotFoundFailure());
    }
  }
}
