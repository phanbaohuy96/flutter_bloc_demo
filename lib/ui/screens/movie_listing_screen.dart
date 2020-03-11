import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo/base/bloc_base.dart';
import 'package:flutter_bloc_demo/base/state_base.dart';
import 'package:flutter_bloc_demo/blocs/movie_bloc.dart';
import 'package:flutter_bloc_demo/ui/screens/movie_list.dart';
import 'package:flutter_bloc_demo/ui/widgets/simple_button.dart';
import 'package:flutter_bloc_demo/utils/dimension.dart';
import 'package:flutter_bloc_demo/utils/extension.dart';
import 'package:flutter_bloc_demo/utils/utils.dart';

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
            if (snapshot.data == MovieListingScreenState.done) {
              return Text('${bloc.movieResponse.results.length} Movie');
            } else {
              return const Text('Movie Listing');
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
            bloc.initial();
            return const SizedBox();
          }
          switch (snapshot.data) {
            case MovieListingScreenState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case MovieListingScreenState.retry:
              return Center(
                child: SimpleButton(
                  height: 45,
                  width: 145,
                  text: 'Retry',
                  onPressed: () => bloc.retryGetMovies(),
                ),
              );
            case MovieListingScreenState.done:
              return MovieList();
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  @override
  void showErrorDialog(String message) {
    super.showErrorDialog(message);
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
            titleButton: 'Retry',
            onTap: () {
              bloc.retryGetMovies();
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  @override
  void showNoInternetDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: errorInternet(
            width: Dimension.getWidth(0.9),
            height: Dimension.getWidth(0.9),
            titleButton: 'Retry',
            onTap: () {
              bloc.retryGetMovies();
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
