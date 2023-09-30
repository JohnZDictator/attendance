import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/core.dart';
import '../../../features.dart';

abstract class AuthenticationRemoteDataSource {
  Future<EventModel> fetchEvent();
  Future<User> login({
    required String email,
    required String password,
  });
  Future<void> logout();
}

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDataSource {
  AuthenticationRemoteDataSourceImpl({
    required this.client,
  });

  final http.Client client;

  @override
  Future<EventModel> fetchEvent() async {
    final response = await client.get(
      Uri.parse('$baseUrl/HRM/GetTodayEvent'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return EventModel.fromJson(data);
    } else if (response.statusCode == 404) {
      throw EventNotFoundException();
    }
    throw ServerException();
  }

  @override
  Future<User> login({required String email, required String password}) async {
    final payload = json.encode(
      {
        'email': email,
        'password': password,
        'name': 'true',
        'phone': 'true',
        'isActive': true
      },
    );
    final response = await client.post(
      Uri.parse('$baseUrl/AppUser/Authentication'),
      body: payload,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return UserModel.fromJson(data);
    } else if (response.statusCode == 404) {
      throw UserNotFoundException();
    }
    throw ServerException();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
