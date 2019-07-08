import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_buddy/bloc/bloc.dart';
import 'package:movie_buddy/widgets/movie_list_item_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _moviesBloc = BlocProvider.of<MoviesBloc>(context);
    _moviesBloc.dispatch(LoadUpcomingMovies());
    return Scaffold(
      appBar: AppBar(title: Text('UPCOMING MOVIES')),
      body: BlocBuilder(
        bloc: _moviesBloc,
        builder: (BuildContext context, MoviesState state) {
          if (state is MoviesLoaded) {
            final listItems =
                state.movies.map<MovieListItem>((m) => MovieListItem(m.name, m.poster.toString(), m.genre, m.releaseDate));
            return _buildMoviesList(listItems.toList());
          } else if (state is IsLoading) {
            return _buildLoadingState();
          } else {
            return Center(child: Text('No movies to display'));
          }
        },
      ),
    );
  }

  Center _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 30),
          Text('Loading upcoming movies'),
          SizedBox(height: 120),
        ],
      ),
    );
  }

  Widget _buildMoviesList(List<MovieListItem> movies) {
    return movies.isEmpty
        ? Center(child: Text('No movies to display'))
        : ListView.builder(
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) => MovieListItemWidget(movies[index]),
          );
  }
}



class MovieListItem {
  final String name;
  final String poster;
  final String genre;
  final DateTime releaseDate;

  MovieListItem(this.name, this.poster, this.genre, this.releaseDate);
}
