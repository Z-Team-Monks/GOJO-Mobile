import 'package:flutter/material.dart';

import 'Gojo-Mobile-Shared/resources/resources.dart';
import 'features/home/presentation/screen/home_view.dart';
import 'features/messages/contacts/presentation/screen/contacts_view.dart';
import 'features/notification/presentation/notification_view.dart';
import 'features/profile/presentation/screens/profile_view.dart';
import 'features/transactions/presentation/screens/transactions_view.dart';

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
    const ProfileView(),
    const NotificationView(),
    const TransactionsView(),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Resources.gojoColors.primaryColor,
        unselectedItemColor: Resources.gojoColors.darkGrey,
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
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.paid),
            label: "Transactions",
          ),
        ],
      ),
    );
  }
}
