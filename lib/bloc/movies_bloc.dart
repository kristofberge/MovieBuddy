import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:movie_buddy/models/movie_model.dart';
import 'package:movie_buddy/util/mapper.dart';
import 'package:movie_buddy/util/uri_builder.dart';
import './bloc.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final http.Client _client;
  final UriBuilder _uriBuilder;
  final Mapper _mapper;

  MoviesBloc(this._client, this._uriBuilder, this._mapper);

  @override
  MoviesState get initialState => InitialMoviesState();

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    try {
      if (event is LoadUpcomingMovies) {
        yield IsLoading();
        var url = _uriBuilder.getUpcomingMoviesUrl().toString();
        final response = await _client.get(url);
        if (response.statusCode == 200 || response.statusCode == 201) {
          final responseBody = json.decode(response.body);
          final List<dynamic> moviesMap = responseBody['results'];
          var mapList = moviesMap.cast<Map<String, dynamic>>();
          List<Movie> movies = _mapper.mapToMoviesList(mapList);
          yield MoviesLoaded(movies);
        }
      }
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
    }
  }
}
