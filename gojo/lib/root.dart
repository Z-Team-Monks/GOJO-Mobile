import 'package:flutter/material.dart';

import 'Gojo-Mobile-Shared/resources/resources.dart';
import 'features/home/presentation/screen/home_view.dart';
import 'features/messages/contacts/presentation/screen/contacts_view.dart';
import 'features/profile/presentation/screen/profile_view.dart';
import 'features/transactions/presentation/screens/transactions_view.dart';
import 'Gojo-Mobile-Shared/shared_features/notification/repository/notification_service.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  int _selectedTab = 0;

  final List _pages = [
    const HomeView(),
    const ContactsView(),
    const TransactionsView(),
    const ProfileView(),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // The notification service is set up here because it needs the context
    // object to show a notification bar.
    // Another reason is that the notification service should start after a user
    // has logged in.
    NotificationService.setUp(context);

    return Scaffold(
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Resources.gojoColors.primaryColor,
        unselectedItemColor: Resources.gojoColors.darkGrey,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        selectedFontSize: 12,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Messages",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments),
            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments_outlined),
            label: "Transactions",
          ),
        ],
      ),
    );
  }
}
