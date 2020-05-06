import 'package:DC_Note/core/statics/colors.dart';
import 'package:DC_Note/pages/add_product/add_product_screen.dart';
import 'package:DC_Note/pages/splash/splash_screen.dart';
import 'package:DC_Note/pages/tabs/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/statics/application.dart';

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
  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DC Note',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale("pl", "PL")],
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.appGrey,
        fontFamily: "Montserrat",
        accentColor: AppColors.secondary,
        primaryColor: AppColors.primary,
        snackBarTheme: SnackBarThemeData(
            backgroundColor: AppColors.primary,
            contentTextStyle:
                TextStyle(fontWeight: FontWeight.bold, height: 1.5)),
        primaryColorLight: AppColors.primaryLight,
      ),
      initialRoute: "/",
      routes: {
        '/': (ctx) => SplashScreen(),
        '/tabs': (ctx) => TabsScreen(),
        '/addProduct': (ctx) => AddProductScreen()
      },
    );
    return app;
  }
}
