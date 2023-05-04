import 'package:flutter/material.dart';

import '../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import 'user_request.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  scrollTo(int page) {
    setState(() {
      currentPage = page;

      _pageController.animateToPage(currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate);
    });
  }

  Widget buildPageViewTab(
      {required label,
      required Function(String?) onSelected,
      isSelected = false}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onSelected(label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: isSelected
              ? const BoxDecoration(
                  border: Border(bottom: BorderSide(width: 2)))
              : null,
          child: Text(
            label,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: "Application Requests",
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildPageViewTab(
                  label: "Requests",
                  isSelected: currentPage == 0,
                  onSelected: (val) => scrollTo(0)),
              buildPageViewTab(
                  label: "Approved",
                  isSelected: currentPage == 1,
                  onSelected: (val) => scrollTo(1)),
              buildPageViewTab(
                  label: "Rejected",
                  isSelected: currentPage == 2,
                  onSelected: (val) => scrollTo(2))
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) => {
                setState(() {
                  currentPage = page;
                })
              },
              children: [
                UserRequest(),
                UserRequest(),
                UserRequest(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
