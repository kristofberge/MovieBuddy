import 'package:mockito/mockito.dart';
import 'package:movie_buddy/repos/movies_repository.dart';
import 'package:movie_buddy/util/mapper.dart';
import 'package:movie_buddy/util/uri_builder.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client{}
class MockUriBuilder extends Mock implements UriBuilder{}
class MockMoviesRepository extends Mock implements MoviesRepository {}
class MockMapper extends Mock implements Mapper {}