import 'package:attendance/core/core.dart';
import 'package:attendance/features/authentication/domain/usecases/fetch_event_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../features.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final FetchUserUsecase fetchUserUsecase;
  final FetchEventUsecase fetchEventUsecase;

  AuthenticationBloc({
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.fetchUserUsecase,
    required this.fetchEventUsecase,
  }) : super(AuthenticationInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<FetchEvent>(_onFetchEvent);
  }

  void _onLoginEvent(
    LoginEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const LoginState(status: AuthenticationStatus.loading));
    final loginOrFailed = await loginUsecase(
      LoginParams(
        email: event.email,
        password: event.password,
      ),
    );
    emit(
      loginOrFailed.fold(
        (l) {
          final errorMessage = _errorMessage(l);
          return LoginState(
            status: AuthenticationStatus.error,
            errorMessage: errorMessage,
          );
        },
        (user) => LoginState(status: AuthenticationStatus.loaded, user: user),
      ),
    );
  }

  void _onLogoutEvent(
    LogoutEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const LogoutState(status: AuthenticationStatus.loading));
    final logoutOrFailure = await logoutUsecase(NoParams());
    emit(
      logoutOrFailure.fold(
        (l) {
          final errorMessage = _errorMessage(l);
          return LogoutState(
            status: AuthenticationStatus.error,
            errorMessage: errorMessage,
          );
        },
        (r) => const LogoutState(status: AuthenticationStatus.loaded),
      ),
    );
  }

  void _onFetchEvent(
      FetchEvent event, Emitter<AuthenticationState> emit) async {
    emit(const FetchEventState(status: AuthenticationStatus.loading));
    final fetchEventOrFailure = await fetchEventUsecase(NoParams());
    emit(
      fetchEventOrFailure.fold(
        (l) {
          final errorMessage = _errorMessage(l);
          return FetchEventState(
            status: AuthenticationStatus.error,
            errorMessage: errorMessage,
          );
        },
        (event) =>
            FetchEventState(status: AuthenticationStatus.loaded, event: event),
      ),
    );
  }

  String _errorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case UserNotFoundFailure:
        return 'User Not Found';
      case EventNotFoundFailure:
        return 'Event Not Found';
      case NetworkFailure:
        return 'Network Failure';
      case ServerFailure:
        return 'Server Failure';
      default:
        return 'Uknown Failure';
    }
  }
}
