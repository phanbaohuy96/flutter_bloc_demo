import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo/base/bloc_base.dart';
import 'package:flutter_bloc_demo/blocs/movie_bloc.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  MovieBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<MovieBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildList();
  }

  Widget buildList() {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: bloc.movieResponse.results.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GridTile(
          child: InkWell(
            onTap: () {},
            child: CachedNetworkImage(
              imageUrl: bloc.movieResponse.results[index].posterUrl,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
