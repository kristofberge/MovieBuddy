import 'package:kiwi/kiwi.dart';
import 'package:movie_buddy/blocs/movies/movies_bloc.dart';
import 'package:movie_buddy/repos/genres_repository.dart';
import 'package:movie_buddy/repos/movies_repository.dart';
import 'package:movie_buddy/services/genres_service.dart';
import 'package:movie_buddy/util/mapper.dart';
import 'package:movie_buddy/util/uri_builder.dart';
import 'package:http/http.dart';

part 'injector.g.dart';

abstract class Injector {
  static const String _apiKey = '1f54bd990f1cdfb230adb312546d765d';

  @Register.singleton(Client)
  @Register.factory(UriBuilder, resolvers: {String: 'apiKey'})
  @Register.factory(Mapper)
  @Register.factory(MoviesRepository, from: TmdbMoviesRepository)
  @Register.factory(GenresRepository, from: TmdbGenresRepository)
  @Register.factory(GenresService, from: TmdbGenresRepository)
  @Register.singleton(MoviesBloc)
  void configure();

  void setup() {
    Container().registerInstance(_apiKey, name: 'apiKey');
    configure();
  }

  static Injector get injector => _$Injector();
}