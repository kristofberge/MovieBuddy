import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_buddy/exceptions/api_exception.dart';
import 'package:movie_buddy/util/uri_builder.dart';


abstract class GenresRepository {
  Future<List<Map<String, dynamic>>> getGenres();
}

class TmdbGenresRepository implements GenresRepository {
  final http.Client client;
  final UriBuilder uriBuilder;

  TmdbGenresRepository(this.client, this.uriBuilder);

  @override
  Future<List<Map<String, dynamic>>> getGenres() async {
    var genresUrl = uriBuilder.getGenresUri().toString();
    var response = await client.get(genresUrl);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = json.decode(response.body);
      final List<dynamic> genresMap = responseBody['results'];
      return genresMap.cast<Map<String, dynamic>>();
    }

    throw ApiException('Error getting genres');
  }
}