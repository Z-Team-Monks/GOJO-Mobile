import 'package:flutter/material.dart';

import 'Gojo-Mobile-Shared/resources/resources.dart';
import 'features/messages/contacts/presentation/screen/contacts_view.dart';
import 'features/profile/presentation/screens/profile_view.dart';
import 'features/property/create_property/presentation/screen/create_property_view.dart';
import 'features/wallet/withdrawal.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  int _selectedTab = 0;

  final List _pages = [
    const WalletView(),
    const ContactsView(),
    const CreatePropertyView(),
    const ProfileView(),
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
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        selectedFontSize: 12,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: "Wallet",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Messages",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_home),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
