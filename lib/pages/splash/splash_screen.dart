import 'package:DC_Note/pages/splash/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => SplashBloc()..add(SplashInitEvent()),
      child: Builder(
        builder: (BuildContext context) {
          return BlocListener(
            bloc: BlocProvider.of<SplashBloc>(context),
            listener: (BuildContext context, state) {
              if (state is SplashFinished) {
                Navigator.of(context).pushReplacementNamed("/tabs");
              }
            },
            child: Scaffold(
                body: Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            )),
          );
        },
      ),
    );
  }
}
