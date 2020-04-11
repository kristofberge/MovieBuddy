import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_buddy/models/genre_model.dart';
import 'package:movie_buddy/models/movie_model.dart';
import 'package:movie_buddy/util/mapper.dart';

import '../mocks.dart';

void main() {
  MockUriBuilder uriBuilder;
  Mapper mapper;
  setUp(() {
    uriBuilder = MockUriBuilder();
    mapper = Mapper(uriBuilder);
  });

  test('map movies map to Movie', () {
    List<Map<String, dynamic>> movieMapsList = [
      {
        'title': 'movie title 1',
        'poster_path': '/poster1',
        'genre_ids': [1, 2],
        'release_date': '01-01-2001'
      },
      {
        'title': 'movie title 2',
        'poster_path': '/poster2',
        'genre_ids': [2, 3],
        'release_date': '02-02-2002'
      },
      {
        'title': 'movie title 3',
        'poster_path': '/poster3',
        'genre_ids': [1, 3],
        'release_date': '03-03-2003'
      },
    ];
    // when(mapper.mapToGenresList(any)).
    when(uriBuilder.getUriForImage(any)).thenAnswer((invocation) {
      String arg = invocation.positionalArguments[0];
      return Uri(path: arg);
    });

    List<Movie> expected = [
      Movie(
        'movie title 1',
        Uri(path: '/poster1'),
        [Genre('1', 'genre1'), Genre('2', 'genre2')],
        DateTime(2001, 1, 1),
      ),
      Movie(
        'movie title 2',
        Uri(path: '/poster2'),
        [Genre('2', 'genre2'), Genre('3', 'genre3')],
        DateTime(2002, 2, 2),
      ),
      Movie(
        'movie title 3',
        Uri(path: '/poster3'),
        [Genre('1', 'genre1'), Genre('3', 'genre3')],
        DateTime(2003, 3, 3),
      )
    ];

    List<Movie> movies = mapper.mapToMoviesList(movieMapsList);

    expect(movies, expected);
  });

  test('map genres map to Genre', () {
    List<Map<String, dynamic>> genresMapList = [
      {'id': 1, 'name': 'genre1'},
      {'id': 2, 'name': 'genre2'},
      {'id': 3, 'name': 'genre3'},
    ];

    List<Genre> expected = [
      Genre('1', 'genre1'),
      Genre('2', 'genre2'),
      Genre('3', 'genre3'),
    ];

    List<Genre> genres = mapper.mapToGenresList(genresMapList);

    expect(genres, expected);
  });
}
