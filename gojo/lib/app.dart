import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/signin/presentation/screen/signin_view.dart';
import 'features/home/data_layer/repository/home_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeRepositoryAPI homeRepository = HomeRepositoryFake();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: homeRepository),
      ],
      child: const SignInView(),
    );
  }
}
