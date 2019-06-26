import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:movie_buddy/models/movie_model.dart';
import './bloc.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  @override
  MoviesState get initialState => InitialMoviesState();

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    if (event is LoadUpcomingMovies) {
      yield IsLoading();
      await Future.delayed(Duration(seconds: 2));
      List<Movie> movies = [
        Movie('Dancer in the dark', '', 'drama', DateTime.now().subtract(Duration(days: 10))),
        Movie('I am mother', '', 'sci-fi', DateTime.now().subtract(Duration(days: 30))),
        Movie('Split', '', 'drama', DateTime.now().subtract(Duration(days: 1000))),
        Movie('Captain Marvel', '', 'drama', DateTime.now().subtract(Duration(days: 100))),
        Movie('Dancer in the dark', '', 'drama', DateTime.now().subtract(Duration(days: 10))),
        Movie('I am mother', '', 'sci-fi', DateTime.now().subtract(Duration(days: 30))),
        Movie('Split', '', 'drama', DateTime.now().subtract(Duration(days: 1000))),
        Movie('Captain Marvel', '', 'drama', DateTime.now().subtract(Duration(days: 100))),
        Movie('Dancer in the dark', '', 'drama', DateTime.now().subtract(Duration(days: 10))),
        Movie('I am mother', '', 'sci-fi', DateTime.now().subtract(Duration(days: 30))),
        Movie('Split', '', 'drama', DateTime.now().subtract(Duration(days: 1000))),
        Movie('Captain Marvel', '', 'drama', DateTime.now().subtract(Duration(days: 100))),
      ];
      yield MoviesLoaded(movies);
    }
  }
}
