


import 'package:flutter_test/flutter_test.dart';
import 'package:movie_buddy/util/uri_builder.dart';

const _dummyApiKey = 'apiKey';

void main() {
  UriBuilder uriBuilder;

  setUp(() {
    uriBuilder = new UriBuilder(_dummyApiKey);
  });

  test('Upcoming movies', () {
    var upcomingMoviesUrl = uriBuilder.getUpcomingMoviesUrl();
    expect(upcomingMoviesUrl.toString(), 'https://api.themoviedb.org/3/movie/upcoming?api_key=apiKey');
  });

  test('image url', () {
    const _posterPath = '/kqjL17yufvn9OVLyXYpvtyrFfak.jpg';
    var imageUrl = uriBuilder.getUriForImage(_posterPath);
    expect(imageUrl.toString(), 'https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg');
  });
}