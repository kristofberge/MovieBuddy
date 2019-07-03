class UriBuilder {
  static const _baseUrl = 'api.themoviedb.org';
  static const _upcomingMoviesPath = '3/movie/upcoming';
  static const _imageBaseUrl = 'image.tmdb.org';
  static const _imagePath = 't/p/w500';

  static const _apiKeyProp = 'api_key';

  final String apiKey;

  UriBuilder(this.apiKey);

  Uri getUpcomingMoviesUrl() => Uri.https(_baseUrl, _upcomingMoviesPath, {_apiKeyProp: apiKey});

  Uri getUriForImage(String imageName) => Uri.https(_imageBaseUrl, '$_imageBaseUrl/$imageName');
}
