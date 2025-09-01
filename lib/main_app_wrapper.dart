import 'package:flutter/material.dart';
import 'widgets/bottom_nav_bar.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/barcode_screen.dart';
import 'screens/alerts_screen.dart';
import 'screens/history_screen.dart';

class MainAppWrapper extends StatefulWidget {
  const MainAppWrapper({super.key});

  @override
  State<MainAppWrapper> createState() => _MainAppWrapperState();
}

class _MainAppWrapperState extends State<MainAppWrapper> {
  BottomAppBarItems _selectedItem = BottomAppBarItems.home;

  void _onItemSelected(BottomAppBarItems item) {
    setState(() {
      _selectedItem = item;
    });
  }

  Widget _getCurrentScreen() {
    switch (_selectedItem) {
      case BottomAppBarItems.home:
        return const HomeScreen();
      case BottomAppBarItems.search:
        return const SearchScreen();
      case BottomAppBarItems.barcode:
        return const BarcodeScreen();
      case BottomAppBarItems.alerts:
        return const AlertsScreen();
      case BottomAppBarItems.history:
        return const HistoryScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _getCurrentScreen(),
      bottomNavigationBar: BottomNavBar(
        selectedItem: _selectedItem,
        onItemSelected: _onItemSelected,
      ),
    );
  }
}