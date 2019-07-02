import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:movie_buddy/exceptions/api_exception.dart';
import 'package:movie_buddy/models/movie_model.dart';
import 'package:movie_buddy/repos/movies_repository.dart';
import 'package:movie_buddy/util/mapper.dart';
import './bloc.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final Mapper _mapper;
  final MoviesRepository _repository;

  MoviesBloc(this._repository, this._mapper);

  @override
  MoviesState get initialState => InitialMoviesState();

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    try {
      if (event is LoadUpcomingMovies) {
        yield IsLoading();
        var mapList = await _repository.getUpcomingMovies();
        List<Movie> movies = _mapper.mapToMoviesList(mapList);
        yield MoviesLoaded(movies);
      }
    } on ApiException catch (e) {
      print(e);
    }
  }
}
