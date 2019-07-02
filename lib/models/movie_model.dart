import 'package:equatable/equatable.dart';

class Movie extends Equatable{
  final String name;
  final Uri poster;
  final String genre;
  final DateTime releaseDate;

  Movie(this.name, this.poster, this.genre, this.releaseDate);
}
