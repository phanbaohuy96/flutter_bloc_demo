import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo/base/bloc_base.dart';
import 'package:flutter_bloc_demo/base/state_base.dart';
import 'package:flutter_bloc_demo/blocs/movie_bloc.dart';
import 'package:flutter_bloc_demo/ui/screens/movie_list.dart';
import 'package:flutter_bloc_demo/utils/dimension.dart';
import 'package:flutter_bloc_demo/utils/extension.dart';

class MovieListingScreen extends StatefulWidget {
  @override
  _MovieListingScreenState createState() => _MovieListingScreenState();
}

class _MovieListingScreenState extends StateBase<MovieListingScreen> {
  MovieBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<MovieBloc>(context);
    super.initState();
  }

  @override
  BlocBase getBloc() {
    return bloc;
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<Object>(
          stream: bloc.movieListingStream,
          initialData: bloc.movieListingScreenState,
          builder: (context, snapshot) {
            if (snapshot.data == MovieListingScreenState.initial) {
              return const Text('Movie Listing');
            } else {
              return Text('${bloc.movieResponse.results.length} Movie');
            }
          },
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<MovieListingScreenState>(
        stream: bloc.movieListingStream,
        initialData: bloc.movieListingScreenState,
        builder: (context, snapshot) {
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data == MovieListingScreenState.initial) {
            bloc.getMovies();
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return MovieList();
          }
        },
      ),
    );
  }

  @override
  void showErrorDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: errorNotiedErrorPopup(
            width: Dimension.getWidth(0.9),
            height: Dimension.getWidth(0.9),
            content: message,
            onTap: () {
              Navigator.pop(context);
              bloc.changeMovieListingState(MovieListingScreenState.initial);
            },
          ),
        );
      },
    );
  }
}
