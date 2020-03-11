import 'package:json_annotation/json_annotation.dart';

part 'movie_data.g.dart';

@JsonSerializable()
class Movie {
  @JsonKey(name: 'id', includeIfNull: true)
  final int id;
  @JsonKey(name: 'video', includeIfNull: true)
  final bool isVideo;
  @JsonKey(name: 'title', includeIfNull: true)
  final String title;
  @JsonKey(name: 'poster_path', includeIfNull: true)
  final String posterPath;
  @JsonKey(name: 'backdrop_path', includeIfNull: true)
  final String backDropPath;
  @JsonKey(name: 'overview', includeIfNull: false)
  final String overview;

  Movie({
    this.id,
    this.isVideo,
    this.title,
    this.posterPath,
    this.overview,
    this.backDropPath,
  });

  String get posterUrl => 'https://image.tmdb.org/t/p/w185$posterPath';
  String get backDropUrl => 'https://image.tmdb.org/t/p/w500$backDropPath';

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

@JsonSerializable()
class MovieResponse {
  @JsonKey(name: 'page', includeIfNull: true)
  final int page;
  @JsonKey(name: 'total_results', includeIfNull: true)
  final int totalResult;
  @JsonKey(name: 'total_pages', includeIfNull: true)
  final int totalPage;
  @JsonKey(name: 'results', includeIfNull: true)
  final List<Movie> results;

  MovieResponse({
    this.page,
    this.totalResult,
    this.totalPage,
    this.results,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
