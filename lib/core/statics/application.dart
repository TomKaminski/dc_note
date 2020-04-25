import 'package:DC_Note/database/app_database.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class Application {
  Application._();
  static GetIt serviceLocator;
  static ThemeData appTheme;
  static AppDatabase database;
  static final networkSubject = BehaviorSubject<ConnectivityResult>();

  static void init() {
    Application.serviceLocator = GetIt.instance;
    Application.serviceLocator.allowReassignment = true;
    Application.database = AppDatabase();

    initDependencies(serviceLocator);
  }

  static void initDependencies(GetIt serviceLocator) {}
}
