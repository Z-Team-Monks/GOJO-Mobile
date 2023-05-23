import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/splash.dart';
import 'package:gojo/constants/strings/app_routes.dart';
import 'package:gojo/features/route_guard/presentation/bloc/route_guard_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RouteGuardBloc, RouteGuardState>(
      listener: (context, state) {
        switch (state) {
          case RouteGuardState.authenticated:
            Navigator.of(context).pushNamedAndRemoveUntil(
              GojoRoutes.root,
              (Route<dynamic> route) => false,
            );
            break;
          case RouteGuardState.unauthenticated:
            Navigator.of(context).pushNamedAndRemoveUntil(
              GojoRoutes.signin,
              (Route<dynamic> route) => false,
            );
            break;
          case RouteGuardState.loading:
            break;
        }
      },
      builder: (context, state) {
        return Center(child: GojoSplash(
          nextScreen: () async {
            return await Container();
          },
        ));
      },
    );
  }
}
