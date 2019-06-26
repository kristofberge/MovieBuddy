import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_buddy/bloc/bloc.dart';

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
                state.movies.map<MovieListItem>((m) => MovieListItem(m.name, m.poster, m.genre, m.releaseDate));
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
        : ListView.separated(
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              final item = movies[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    child: Text(item.name, style: TextStyle(fontSize: 18)),
                    padding: EdgeInsets.only(left: 20, top: 10, right: 10, bottom: 16),
                  ),
                  Padding(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(item.genre),
                        SizedBox(width: 20),
                        Text(DateFormat.yMMMd().format(item.releaseDate))
                      ],
                    ),
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  )
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.grey, height: 2),
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
