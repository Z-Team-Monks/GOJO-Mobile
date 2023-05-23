import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/splash.dart';
import 'package:gojo/features/auth/signin/presentation/screen/signin_view.dart';
import 'package:gojo/features/route_guard/presentation/bloc/route_guard_bloc.dart';
import 'package:gojo/root.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouteGuardBloc, RouteGuardState>(
      builder: (context, state) {
        switch (state) {
          case RouteGuardState.authenticated:
            return const RootView();
          case RouteGuardState.unauthenticated:
            return const SignInView();
          case RouteGuardState.loading:
            return const GojoSplash();
        }
      },
    );
  }
}
