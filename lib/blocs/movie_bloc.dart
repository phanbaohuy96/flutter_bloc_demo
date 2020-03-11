import 'dart:async';

import 'package:flutter_bloc_demo/base/bloc_base.dart';
import 'package:flutter_bloc_demo/data/model/movie_data.dart';
import 'package:flutter_bloc_demo/networking/remote_contract.dart';
import 'package:flutter_bloc_demo/utils/utils.dart';

enum MovieListingScreenState { initial, loading, done, retry }

class MovieBloc extends BlocBase {
  MovieListingScreenState movieListingScreenState =
      MovieListingScreenState.initial;
  final StreamController<MovieListingScreenState> _movieListingController;
  Stream get movieListingStream => _movieListingController.stream;

  //data
  MovieResponse movieResponse;

  MovieBloc()
      : _movieListingController =
            StreamController<MovieListingScreenState>.broadcast();

  void initial() {
    changeMovieListingState(MovieListingScreenState.loading);
    _getMovies();
  }

  void retryGetMovies() {
    changeMovieListingState(MovieListingScreenState.loading);
    _getMovies();
  }

  void _getMovies() {
    appApiService.client.getVideos(RemoteContract.apiKey).then((res) {
      if (res != null) {
        movieResponse = res;
        changeMovieListingState(MovieListingScreenState.done);
      }
    }).catchError((error) {
      log(error);
      changeMovieListingState(MovieListingScreenState.retry);
    });
  }

  void changeMovieListingState(MovieListingScreenState state) {
    if (!_movieListingController.isClosed) {
      movieListingScreenState = state;
      _movieListingController.add(movieListingScreenState);
    }
  }

  @override
  void dispose() {
    _movieListingController.close();
  }
}
