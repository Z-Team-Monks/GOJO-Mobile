import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo/features/auth/signin/presentation/screen/signin_view.dart';
import 'package:gojo/features/home/data_layer/repository/home_client.dart';
import 'package:gojo/features/home/data_layer/repository/home_repository.dart';
import 'package:gojo/features/home/presentation/bloc/property_items/property_items_bloc.dart';
import 'package:gojo/features/home/presentation/screen/home_view.dart';

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
