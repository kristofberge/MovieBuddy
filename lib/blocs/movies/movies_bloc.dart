import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_buddy/exceptions/api_exception.dart';
import 'package:movie_buddy/models/movie_model.dart';
import 'package:movie_buddy/repos/genres_repository.dart';
import 'package:movie_buddy/repos/movies_repository.dart';
import 'package:movie_buddy/services/genres_service.dart';
import 'package:movie_buddy/util/mapper.dart';

import '../bloc.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository moviesRepo;
  final GenresService genresService;
  final Mapper mapper;
  
    MoviesBloc(this.moviesRepo, this.genresService, this.mapper);
  
    @override
    MoviesState get initialState => InitialMoviesState();
  
    @override
    Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
      try {
        if (event is LoadUpcomingMovies) {
          yield IsLoadingMovies();
          var mapList = await moviesRepo.getUpcomingMovies();
          List<Movie> movies = mapper.mapToMoviesList(mapList);
          yield MoviesLoaded(movies);
        }
      } on ApiException catch (e) {
        print(e);
      }
    }
  
    @override
    void onError(Object error, StackTrace stacktrace) {
      super.onError(error, stacktrace);
    }
  }