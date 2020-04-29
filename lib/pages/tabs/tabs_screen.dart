import 'package:DC_Note/core/statics/colors.dart';
import 'package:DC_Note/pages/products/products_screen.dart';
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabsScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget getChild() {
    switch (_selectedIndex) {
      case 0:
        return ProductsScreen();
      case 1:
        return ProductsScreen();
      case 2:
        return ProductsScreen();
      default:
        return ProductsScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getChild(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          backgroundColor: AppColors.softMain,
          type: BottomNavigationBarType.shifting,
          onTap: _onItemTapped,
          items: [
            createBottomNavItem(0, "Produkty"),
            createBottomNavItem(1, "Uzywane"),
          ]),
    );
  }

  BottomNavigationBarItem createBottomNavItem(int index, String text) {
    return BottomNavigationBarItem(
      backgroundColor: AppColors.main,
      title: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
      ),
      icon: ClayContainer(
        color: AppColors.main,
        curveType: CurveType.concave,
        borderRadius: 40,
        spread: 1,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            Icons.account_box,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
