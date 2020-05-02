import 'package:DC_Note/core/statics/colors.dart';
import 'package:DC_Note/pages/splash/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loaded = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 200)).then((value) {
      setState(() {
        loaded = true;
      });
    });
  }

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Ładowanie",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ImageIcon(
                      AssetImage("assets/images/body.png"),
                      color: AppColors.secondary,
                      size: 28,
                    ),
                    SizedBox(width: 6),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: loaded ? 1 : 0,
                      child: ImageIcon(
                        AssetImage("assets/images/comb.png"),
                        color: AppColors.secondary,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: 6),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 1000),
                      opacity: loaded ? 1 : 0,
                      child: ImageIcon(
                        AssetImage("assets/images/face-mask.png"),
                        color: AppColors.secondary,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: 6),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 1500),
                      opacity: loaded ? 1 : 0,
                      child: ImageIcon(
                        AssetImage("assets/images/nail-polish.png"),
                        color: AppColors.secondary,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: 6),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 2000),
                      opacity: loaded ? 1 : 0,
                      child: ImageIcon(
                        AssetImage("assets/images/make-up.png"),
                        color: AppColors.secondary,
                        size: 28,
                      ),
                    ),
                  ]),
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
