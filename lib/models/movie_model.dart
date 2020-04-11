import 'package:equatable/equatable.dart';

import 'genre_model.dart';

class Movie extends Equatable{
  final String name;
  final Uri poster;
  final List<Genre> genres;
  final DateTime releaseDate;

  Movie(this.name, this.poster, this.genres, this.releaseDate);
}
