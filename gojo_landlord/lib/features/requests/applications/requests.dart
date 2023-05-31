import 'package:flutter/material.dart';

import '../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import 'widgets/user_request.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: "Application Requests",
      child: SingleChildScrollView(
        child: Column(
          children: const [
            UserRequest(),
            UserRequest(),
            UserRequest(),
            UserRequest(),
          ],
        ),
      ),
    );
  }
}
