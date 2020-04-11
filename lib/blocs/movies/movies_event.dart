import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MoviesEvent extends Equatable {
  MoviesEvent([List props = const []]) : super(props);
}

class LoadUpcomingMovies extends MoviesEvent {
  LoadUpcomingMovies() : super();
}

class LoadGenres extends MoviesEvent {
  LoadGenres() : super();
}