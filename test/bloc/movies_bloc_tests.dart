import 'package:flutter_test/flutter_test.dart';
import 'package:movie_buddy/blocs/bloc.dart';
import 'package:movie_buddy/models/genre_model.dart';
import 'package:movie_buddy/models/movie_model.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_buddy/repos/genres_repository.dart';
import '../mocks.dart';

void main() {
  MoviesBloc moviesbloc;
  MockMoviesRepository moviesRepo;
  MockGenresRepository genresRepo;
  MockMapper mapper;

  setUp(() {
    mapper = MockMapper();
    moviesRepo = MockMoviesRepository();
    genresRepo = MockGenresRepository();
    moviesbloc = MoviesBloc(moviesRepo, genresRepo, mapper);
  });

  test('initial state is correct', () {
    expect(moviesbloc.initialState, InitialMoviesState());
  });

  test('dispose does not emit new state', () {
    moviesbloc.dispose();
    expectLater(moviesbloc.state, emitsInOrder([]));
  });

  group('fetch upcoming movies', () {
    test('valid response from API', () {
      final List<Map<String, dynamic>> dummyMoviesMaps = [
        {'moviekey1': 'movievalue1'},
        {'moviekey2': 'movievalue2'}
      ];
      final List<Movie> dummyMoviesList = [
        Movie('moviename1', Uri(), [Genre()], DateTime.now()),
        Movie('moviename2', Uri(), 'moviegenre2', DateTime.now())
      ];
      when(moviesRepo.getUpcomingMovies()).thenAnswer((_) => Future.value(dummyMoviesMaps));
      when(mapper.mapToMoviesList(dummyMoviesMaps)).thenReturn(dummyMoviesList);

      final List<Map<String, dynamic>> dummyGenresMaps = [
        {'1': 'genre1'},
        {'2': 'genre2'},
        {'3': 'genre3'}
      ];
      final List<Genre> dymmyGenresList = [
        Genre('1', 'genre1'),
        Genre('2', 'genre2'),
        Genre('3', 'genre3')
      ];
      when(genresRepo.getGenres()).thenAnswer((_) => Future.value(dummyGenresMaps));
      when(mapper.mapToGenresList(dummyGenresMaps)).thenReturn(dymmyGenresList);

      moviesbloc.dispatch(LoadUpcomingMovies());

      expectLater(
          moviesbloc.state, emitsInOrder([InitialMoviesState(), IsLoadingMovies(), MoviesLoaded(dummyMoviesList)]));
    });
  });
}
