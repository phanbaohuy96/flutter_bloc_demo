// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    id: json['id'] as int,
    isVideo: json['video'] as bool,
    title: json['title'] as String,
    posterPath: json['poster_path'] as String,
    overview: json['overview'] as String,
    backDropPath: json['backdrop_path'] as String,
  );
}

Map<String, dynamic> _$MovieToJson(Movie instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'video': instance.isVideo,
    'title': instance.title,
    'poster_path': instance.posterPath,
    'backdrop_path': instance.backDropPath,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('overview', instance.overview);
  return val;
}

MovieResponse _$MovieResponseFromJson(Map<String, dynamic> json) {
  return MovieResponse(
    page: json['page'] as int,
    totalResult: json['total_results'] as int,
    totalPage: json['total_pages'] as int,
    results: (json['results'] as List)
        ?.map(
            (e) => e == null ? null : Movie.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MovieResponseToJson(MovieResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'total_results': instance.totalResult,
      'total_pages': instance.totalPage,
      'results': instance.results,
    };
