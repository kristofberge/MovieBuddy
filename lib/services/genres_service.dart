import 'package:movie_buddy/models/genre_model.dart';
import 'package:movie_buddy/repos/genres_repository.dart';

abstract class GenresService {
  Future loadGenres();
  Genre getGenreFor(int id);
}

class TmdbGenresService implements GenresService {
  final GenresRepository genresRepository;

  TmdbGenresService(this.genresRepository);

  @override
  Genre getGenreFor(int id) {
    // TODO: implement getGenreFor
    return null;
  }

  @override
  Future loadGenres() {
    // TODO: implement loadGenres
    return null;
  }

}