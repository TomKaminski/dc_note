import 'package:DC_Note/pages/add_product/add_product_screen.dart';
import 'package:DC_Note/pages/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/statics/application.dart';
import 'generated/l10n.dart';

void main() {
  Application.init();
  runApp(AppComponent());
}

class AppComponent extends StatefulWidget {
  @override
  State createState() {
    return AppComponentState();
  }
}

class AppComponentState extends State<AppComponent> {
  final mainColor = Colors.pink;

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'DC Note',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        accentColor: mainColor,
        canvasColor: mainColor,
        primaryColor: mainColor,
        snackBarTheme: SnackBarThemeData(
            backgroundColor: mainColor,
            contentTextStyle:
                TextStyle(fontWeight: FontWeight.bold, height: 1.5)),
        primaryColorLight: Color.fromARGB(255, 85, 58, 144),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
            elevation: 0,
            color: Colors.white,
            textTheme: TextTheme(
                headline6: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            iconTheme: IconThemeData(color: Colors.black)),
      ),
      initialRoute: "/",
      routes: {
        '/': (ctx) => ProductsScreen(),
        '/addProduct': (ctx) => AddProductScreen()
      },
    );
    return app;
  }
}
