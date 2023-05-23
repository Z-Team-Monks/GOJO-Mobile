import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gojo/core/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'route_guard_event.dart';
part 'route_guard_state.dart';

class RouteGuardBloc extends Bloc<RouteGuardEvent, RouteGuardState> {
  final UserRepositoryAPI userRepository;

  RouteGuardBloc(this.userRepository) : super(RouteGuardState.loading) {
    on<LoadRouteGuardStatus>((event, emit) async {
      final user = await userRepository.getUser();
      if (user != null) {
        emit(RouteGuardState.authenticated);
      } else {
        emit(RouteGuardState.unauthenticated);
      }
    });
    on<Logout>((event, emit) async {
      emit(RouteGuardState.loading);
      await userRepository.deleteUser();
      emit(RouteGuardState.unauthenticated);
    });
  }
}
