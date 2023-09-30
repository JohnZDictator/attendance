import 'package:attendance/features/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginState && state.status == AuthenticationStatus.error) {
          final snackBar = SnackBar(
            content: Text(state.errorMessage!),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating, // Make it floating
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is LoginState &&
            state.status == AuthenticationStatus.loaded) {
          const snackBar = SnackBar(
            content: Text('Success'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating, // Make it floating
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          context.go(AppRoutes.homePage);
        }
      },
      child: const Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login Page',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 24),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
