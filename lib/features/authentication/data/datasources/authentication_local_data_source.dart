import 'dart:convert';

import 'package:attendance/core/constants/constants.dart';
import 'package:attendance/core/core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../features.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel> fetchUser();
  Future<void> logout();
  Future<void> cacheEvent(EventModel event);
  Future<EventModel> fetchEvent();
  Future<void> clearEvent();
}

class AuthenticationLocalDataSourceImpl extends AuthenticationLocalDataSource {
  AuthenticationLocalDataSourceImpl({
    required this.flutterSecureStorage,
  });

  final FlutterSecureStorage flutterSecureStorage;

  @override
  Future<void> cacheUser(UserModel user) {
    String? userStringified = json.encode(user);
    return flutterSecureStorage.write(
      key: authenticationKey,
      value: userStringified,
    );
  }

  @override
  Future<UserModel> fetchUser() async {
    final user = await flutterSecureStorage.read(key: authenticationKey);

    if (user != null) {
      return Future.value(
        UserModel.fromJson(
          json.decode(user),
        ),
      );
    } else {
      throw UserNotFoundException();
    }
  }

  @override
  Future<void> logout() async {
    return await flutterSecureStorage.delete(key: authenticationKey);
  }

  @override
  Future<void> cacheEvent(EventModel event) {
    String? eventStringified = json.encode(event);
    return flutterSecureStorage.write(
      key: eventKey,
      value: eventStringified,
    );
  }

  @override
  Future<EventModel> fetchEvent() async {
    final event = await flutterSecureStorage.read(key: eventKey);

    if (event != null) {
      return Future.value(
        EventModel.fromJson(
          json.decode(event),
        ),
      );
    } else {
      throw EventNotFoundException();
    }
  }

  @override
  Future<void> clearEvent() async {
    return await flutterSecureStorage.delete(key: eventKey);
  }
}
