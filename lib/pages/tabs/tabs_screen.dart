import 'package:DC_Note/core/statics/adds.dart';
import 'package:DC_Note/core/statics/colors.dart';
import 'package:DC_Note/pages/about/about_screen.dart';
import 'package:DC_Note/pages/in_use_products/in_use_products_page.dart';
import 'package:DC_Note/pages/products/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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
        return ProductsPage();
      case 1:
        return InUseProductsPage();
      case 2:
        return AboutScreen();
      default:
        return ProductsPage();
    }
  }

  @override
  void initState() {
    super.initState();
    //AppAds.init();
  }

  @override
  void dispose() {
    super.dispose();
    //AppAds.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getChild(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.shifting,
          onTap: _onItemTapped,
          items: [
            createBottomNavItem(0, "Produkty", Icons.list),
            createBottomNavItem(1, "Używane", Icons.star_border),
            createBottomNavItem(2, "O aplikacji", Icons.info_outline),
          ]),
    );
  }

  BottomNavigationBarItem createBottomNavItem(
      int index, String text, IconData icon) {
    return BottomNavigationBarItem(
      backgroundColor: AppColors.primary,
      title: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
      ),
      icon: Neumorphic(
        style: NeumorphicStyle(
            color: AppColors.buttonsGrey,
            shape: NeumorphicShape.concave,
            depth: _selectedIndex == index ? -20 : 20),
        boxShape:
            NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(14))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Icon(
            icon,
            color: AppColors.secondary,
          ),
        ),
      ),
    );
  }
}
