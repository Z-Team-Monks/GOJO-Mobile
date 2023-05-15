import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';

class VirtualTourView extends StatefulWidget {
  const VirtualTourView({super.key});

  @override
  State<VirtualTourView> createState() => _VirtualTourViewState();
}

class _VirtualTourViewState extends State<VirtualTourView> {
  late final WebViewController controller;
  final virtualTourUrl = 'https://vr-demo-git-main-par0s.vercel.app/';

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(virtualTourUrl),
      );
  }

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      child: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
