import 'dart:async';

import 'package:DC_Note/core/statics/application.dart';
import 'package:DC_Note/core/statics/categories_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashInitEvent, SplashState> {
  @override
  SplashState get initialState => SplashLoading();

  @override
  Stream<SplashState> mapEventToState(
    SplashInitEvent event,
  ) async* {
    yield SplashLoading();
    await CategoriesProvider().insertOrReplaceCategories();
    final categories = await Application.database.categoryDao.getAll();
    yield SplashFinished();
  }
}
