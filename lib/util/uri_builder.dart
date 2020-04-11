class UriBuilder {
  static const _baseUrl = 'api.themoviedb.org';
  static const _version = '3';
  static const _upcomingMoviesPath = '$_version/movie/upcoming';
  static const _movieGenresPath = '$_version/genre/movie/list';
  static const _imageBaseUrl = 'image.tmdb.org';
  static const _imagePath = 't/p/w500';

  static const _apiKeyProp = 'api_key';

  final String apiKey;

  UriBuilder(this.apiKey);

  Uri getUpcomingMoviesUrl() => Uri.https(_baseUrl, _upcomingMoviesPath, {_apiKeyProp: apiKey});

  Uri getUriForImage(String imageName) => Uri.https(_imageBaseUrl, '$_imagePath$imageName');

  Uri getGenresUri() => Uri.https(_baseUrl, _movieGenresPath, {_apiKeyProp: apiKey});
}
