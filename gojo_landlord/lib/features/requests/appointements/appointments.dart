import 'package:flutter/material.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import 'package:gojo_landlord/features/requests/applications/user_request.dart';
import 'package:gojo_landlord/features/requests/appointements/appointment_request.dart';

class AppointmentsView extends StatefulWidget {
  const AppointmentsView({super.key});

  @override
  State<AppointmentsView> createState() => _AppointmentsViewState();
}

class _AppointmentsViewState extends State<AppointmentsView> {
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
      label: "Appointment Requests",
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
                AppointmentRequest(),
                AppointmentRequest(),
                AppointmentRequest(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
