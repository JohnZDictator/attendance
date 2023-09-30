import 'package:go_router/go_router.dart';

import '../../features/features.dart';
import 'app_routes.dart';

final routes = <GoRoute>[
  GoRoute(
    path: AppRoutes.homePage,
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: AppRoutes.loginPage,
    builder: (context, state) => const LoginPage(),
  ),
];
