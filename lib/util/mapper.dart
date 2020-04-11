import 'package:movie_buddy/models/genre_model.dart';
import 'package:movie_buddy/models/movie_model.dart';
import 'package:movie_buddy/util/uri_builder.dart';

class Mapper {
  final UriBuilder uriBuilder;

  Mapper(this.uriBuilder);

  List<Movie> mapToMoviesList(List<Map<String, dynamic>> moviesMap) {
    return moviesMap
        .map(
          (m) => Movie(
                m['title'],
                uriBuilder.getUriForImage(m['poster_path']),
                List<Genre>(),
                _releaseDateStringToDateTime(m['release_date']),
              ),
        )
        .toList();
  }

  List<Genre> mapToGenresList(List<Map<String, dynamic>> genresMap) {
    return genresMap.map((g) => Genre('${g['id']}', g['name'])).toList();
  }

  DateTime _releaseDateStringToDateTime(String releaseDate) {
    final split = releaseDate.split('-');
    if (split.length == 3) {
      return DateTime(int.parse(split[0]), int.parse(split[1]), int.parse(split[2]));
    }

    throw FormatException('Incorrect format. parameter: releaseDate; value: $releaseDate');
  }
}
