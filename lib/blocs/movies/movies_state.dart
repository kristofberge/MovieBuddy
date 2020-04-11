import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_buddy/models/movie_model.dart';

@immutable
abstract class MoviesState extends Equatable {
  MoviesState([List props = const []]) : super(props);
}

class InitialMoviesState extends MoviesState {}

class IsLoadingMovies extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<Movie> movies;
  MoviesLoaded(this.movies) : super([movies]);
}