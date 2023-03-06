import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gojo/Features/home/presentation/screen/home_view.dart';

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gojo"),
        actions: [],
      ),
      body: Center(
        child: HomeView(),
      ),
    );
  }
}
