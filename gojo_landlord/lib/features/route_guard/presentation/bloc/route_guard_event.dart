part of 'route_guard_bloc.dart';

@immutable
abstract class RouteGuardEvent {}

class LoadRouteGuardStatus extends RouteGuardEvent {}

class Logout extends RouteGuardEvent {}
