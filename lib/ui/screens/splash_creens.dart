import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo/base/bloc_base.dart';
import 'package:flutter_bloc_demo/blocs/movie_bloc.dart';
import 'package:flutter_bloc_demo/utils/dimension.dart';

import 'movie_listing_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Dimension.height = MediaQuery.of(context).size.height;
    Dimension.width = MediaQuery.of(context).size.width;
    Dimension.statusBarHeight = MediaQuery.of(context).padding.top;
    Dimension.bottomPadding = MediaQuery.of(context).padding.bottom;

    Future.delayed(
      const Duration(milliseconds: 1100),
    ).then(
      (onValue) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              bloc: MovieBloc(),
              child: MovieListingScreen(),
            ),
          ),
        );
      },
    );

    return Scaffold(
      body: Container(
        width: Dimension.width,
        height: Dimension.height,
        child: const Center(
          child: FlutterLogo(
            size: 100,
          ),
        ),
      ),
    );
  }
}
