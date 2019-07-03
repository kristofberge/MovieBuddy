// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void configure() {
    final Container container = Container();
    container.registerSingleton((c) => Client());
    container.registerFactory((c) => UriBuilder(c<String>('apiKey')));
    container.registerFactory((c) => Mapper(c<UriBuilder>()));
    container.registerFactory<MoviesRepository, TmdbMoviesRepository>(
        (c) => TmdbMoviesRepository(c<Client>(), c<UriBuilder>()));
    container.registerSingleton(
        (c) => MoviesBloc(c<MoviesRepository>(), c<Mapper>()));
  }
}
