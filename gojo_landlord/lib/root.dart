import 'package:flutter/material.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/resources/resources.dart';
import 'package:gojo_landlord/features/messages/contacts/presentation/screen/contacts_view.dart';
import 'package:gojo_landlord/features/notification/presentation/notification_view.dart';
import 'package:gojo_landlord/features/profile/presentation/screens/profile_view.dart';
import 'package:gojo_landlord/features/property/create_property/presentation/screen/create_property_view.dart';
import 'package:gojo_landlord/features/withdrawal/withdrawal.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  int _selectedTab = 0;

  final List _pages = [
    const ProfileView(),
    const ContactsView(),
    const CreatePropertyView(),
    const WithdrawRequest(),
    const NotificationView(),
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messages"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(Icons.paid), label: "Transactions"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notifications"),
        ],
      ),
    );
  }
}
