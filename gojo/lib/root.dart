import 'package:flutter/material.dart';

import 'Gojo-Mobile-Shared/resources/resources.dart';
import 'features/home/presentation/screen/home_view.dart';
import 'features/messages/contacts/presentation/screen/contacts_view.dart';
import 'features/profile/presentation/screen/profile_view.dart';
import 'features/transactions/presentation/screens/transactions_view.dart';
import 'Gojo-Mobile-Shared/shared_features/notification/repository/notification_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: AppLocalizations.of(context)!.messages,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments),
            label: AppLocalizations.of(context)!.transactions,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
      ),
    );
  }
}
