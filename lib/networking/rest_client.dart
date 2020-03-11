import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:flutter_bloc_demo/data/model/movie_data.dart';
import 'package:flutter_bloc_demo/networking/remote_contract.dart';

part 'rest_client.g.dart';

/// https://pub.dev/packages/retrofit

@RestApi(baseUrl: RemoteContract.baseLayerUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('popular')
  Future<MovieResponse> getVideos(
    @Query('api_key') String apiKey,
  );
}
