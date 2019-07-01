import 'package:movie_buddy/models/movie_model.dart';
import 'package:movie_buddy/util/uri_builder.dart';

class Mapper {
  final UriBuilder _uriBuilder;

  Mapper(this._uriBuilder);

  List<Movie> mapToMoviesList(List<Map<String, dynamic>> moviesMap) {
    return moviesMap.map(
      (m) => Movie(
            m['title'],
            _uriBuilder.getUriForImage(m['poster_path']),
            m['genre_ids'].toString(),
            releaseDateStringToDateTime(m['release_date']),
          ),
    ).toList();
  }

  DateTime releaseDateStringToDateTime(String releaseDate) {
    final split = releaseDate.split('-');
    if (split.length == 3) {
      return DateTime(int.parse(split[0]), int.parse(split[1]), int.parse(split[2]));
    }

    throw FormatException('Incorrect format. parameter: releaseDate; value: $releaseDate');
  }
}
