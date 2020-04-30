import 'package:DC_Note/core/statics/colors.dart';
import 'package:DC_Note/pages/in_use_products/in_use_products_page.dart';
import 'package:DC_Note/pages/products/products_page.dart';
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
        return ProductsPage();
      case 1:
        return InUseProductsPage();
      default:
        return ProductsPage();
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
            createBottomNavItem(0, "Produkty", Icons.list),
            createBottomNavItem(1, "Używane", Icons.mood),
          ]),
    );
  }

  BottomNavigationBarItem createBottomNavItem(
      int index, String text, IconData icon) {
    return BottomNavigationBarItem(
      backgroundColor: AppColors.main,
      title: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      icon: ClayContainer(
        color: AppColors.main,
        curveType: CurveType.concave,
        emboss: _selectedIndex == index,
        borderRadius: 40,
        spread: 1,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
