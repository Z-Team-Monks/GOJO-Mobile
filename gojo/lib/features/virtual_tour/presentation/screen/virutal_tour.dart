import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';

class VirtualTourView extends StatefulWidget {
  final int propertyId;

  const VirtualTourView({super.key, required this.propertyId});

  @override
  State<VirtualTourView> createState() => _VirtualTourViewState();
}

class _VirtualTourViewState extends State<VirtualTourView> {
  late final WebViewController controller;
  // final virtualTourUrl = 'https://vr-demo-git-main-par0s.vercel.app/';
  // final virtualTourUrl =
  //     'http://192.168.149.134:3000/tour/view/${widget.propertyId}';

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse('http://192.168.149.134:3000/tour/view/21'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      isFullScreen: true,
      child: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
