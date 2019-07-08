import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_buddy/models/movie_model.dart';
import 'package:movie_buddy/util/mapper.dart';
import 'package:movie_buddy/util/uri_builder.dart';

class MockUriBuilder extends Mock implements UriBuilder {}

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
        'genre_ids': [1, 2, 3],
        'release_date': '01-01-2001'
      },
      {
        'title': 'movie title 2',
        'poster_path': '/poster2',
        'genre_ids': [4, 5, 6],
        'release_date': '02-02-2002'
      },
      {
        'title': 'movie title 3',
        'poster_path': '/poster3',
        'genre_ids': [7, 8, 9],
        'release_date': '03-03-2003'
      },
    ];
    when(uriBuilder.getUriForImage(any)).thenAnswer((invocation) {
      String arg = invocation.positionalArguments[0];
      return Uri(path: arg);
    });

    List<Movie> expected = [
      Movie('movie title 1', Uri(path: '/poster1'), '[1, 2, 3]', DateTime(2001, 1, 1)),
      Movie('movie title 2', Uri(path: '/poster2'), '[4, 5, 6]', DateTime(2002, 2, 2)),
      Movie('movie title 3', Uri(path: '/poster3'), '[7, 8, 9]', DateTime(2003, 3, 3))
    ];

    List<Movie> movies = mapper.mapToMoviesList(movieMapsList);

    expect(movies, expected);
  });
}
