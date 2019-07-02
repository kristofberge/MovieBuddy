import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_buddy/exceptions/api_exception.dart';
import 'package:movie_buddy/util/uri_builder.dart';

abstract class MoviesRepository {
  Future<List<Map<String, dynamic>>> getUpcomingMovies();
}

class TmdbMoviesRepository implements MoviesRepository {
  final http.Client _client;
  final UriBuilder _uriBuilder;

  TmdbMoviesRepository(this._client, this._uriBuilder);

  @override
  Future<List<Map<String, dynamic>>> getUpcomingMovies() async {
    var url = _uriBuilder.getUpcomingMoviesUrl().toString();

    final response = await _client.get(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = json.decode(response.body);
      final List<dynamic> moviesMap = responseBody['results'];
      return moviesMap.cast<Map<String, dynamic>>();
    }

    throw ApiException('Error getting upcoming movies');
  }
}
