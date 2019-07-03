import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:movie_buddy/exceptions/api_exception.dart';
import 'package:movie_buddy/models/movie_model.dart';
import 'package:movie_buddy/repos/movies_repository.dart';
import 'package:movie_buddy/util/mapper.dart';
import './bloc.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final Mapper mapper;
  final MoviesRepository repository;

  MoviesBloc(this.repository, this.mapper);

  @override
  MoviesState get initialState => InitialMoviesState();

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    try {
      if (event is LoadUpcomingMovies) {
        yield IsLoading();
        var mapList = await repository.getUpcomingMovies();
        List<Movie> movies = mapper.mapToMoviesList(mapList);
        yield MoviesLoaded(movies);
      }
    } on ApiException catch (e) {
      print(e);
    }
  }
}
