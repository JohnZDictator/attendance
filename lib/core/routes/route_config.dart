import 'dart:async';

import 'package:attendance/features/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core.dart';

class AppRouter extends StatelessWidget {
  FutureOr<String?> redirector(state) async {
    var isLoggedIn = true;
    try {
      await localDataSource.fetchUser();
    } on UserNotFoundException {
      isLoggedIn = false;
    }

    if (isLoggedIn) {
      if (state.location == AppRoutes.loginPage) {
        return AppRoutes.homePage;
      }
      return state.location;
    } else {
      return null;
    }
  }

  AppRouter({
    super.key,
    required this.localDataSource,
  }) {
    _router = GoRouter(
      redirect: (context, state) => redirector(state),
      initialLocation: AppRoutes.loginPage,
      routes: routes,
    );
  }

  final AuthenticationLocalDataSource localDataSource;
  late final GoRouter _router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}
