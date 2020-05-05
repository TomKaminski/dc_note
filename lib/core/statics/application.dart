import 'package:DC_Note/database/app_database.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Application {
  Application._();
  static GetIt serviceLocator;
  static ThemeData appTheme;
  static AppDatabase database;
  static bool showedFullscreenAdd;
  static bool showedBannerAdd;

  static void init() {
    Application.serviceLocator = GetIt.instance;
    Application.serviceLocator.allowReassignment = true;
    Application.showedFullscreenAdd = false;
    Application.showedBannerAdd = false;

    Application.database = AppDatabase();

    initDependencies(serviceLocator);
  }

  static void initDependencies(GetIt serviceLocator) {}
}
