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

  final softColor = Color.fromARGB(255, 137, 240, 222);
  final mainColor = Color.fromARGB(255, 69, 231, 203);

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
          backgroundColor: softColor,
          type: BottomNavigationBarType.shifting,
          onTap: _onItemTapped,
          items: [
            createBottomNavItem(0, "Produkty"),
            createBottomNavItem(1, "Uzywane"),
            createBottomNavItem(2, "Ustawienia"),
          ]),
    );
  }

  BottomNavigationBarItem createBottomNavItem(int index, String text) {
    return BottomNavigationBarItem(
        backgroundColor: softColor,
        title: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        icon: ClayContainer(
            color: mainColor,
            emboss: _selectedIndex == index,
            curveType: CurveType.concave,
            borderRadius: 40,
            spread: 1,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.account_box,
                color: Colors.white,
              ),
            )));
  }
}
