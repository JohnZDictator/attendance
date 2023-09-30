import 'package:attendance/features/authentication/authentication.dart';
import 'package:attendance/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/core.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => serviceLocator<AuthenticationBloc>(),
        ),
      ],
      child: AppRouter(
        localDataSource: serviceLocator<AuthenticationLocalDataSource>(),
      ),
    ),
  );
}
