import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_buddy/models/movie_list_item.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('UPCOMING MOVIES')),
      body: _buildMoviesList([
        MovieListItem('Dancer in the dark', '', 'drama', DateTime.now().subtract(Duration(days: 10))),
        MovieListItem('I am mother', '', 'sci-fi', DateTime.now().subtract(Duration(days: 30))),
        MovieListItem('Split', '', 'drama', DateTime.now().subtract(Duration(days: 1000))),
        MovieListItem('Captain Marvel', '', 'drama', DateTime.now().subtract(Duration(days: 100))),
        MovieListItem('Dancer in the dark', '', 'drama', DateTime.now().subtract(Duration(days: 10))),
        MovieListItem('I am mother', '', 'sci-fi', DateTime.now().subtract(Duration(days: 30))),
        MovieListItem('Split', '', 'drama', DateTime.now().subtract(Duration(days: 1000))),
        MovieListItem('Captain Marvel', '', 'drama', DateTime.now().subtract(Duration(days: 100))),
        MovieListItem('Dancer in the dark', '', 'drama', DateTime.now().subtract(Duration(days: 10))),
        MovieListItem('I am mother', '', 'sci-fi', DateTime.now().subtract(Duration(days: 30))),
        MovieListItem('Split', '', 'drama', DateTime.now().subtract(Duration(days: 1000))),
        MovieListItem('Captain Marvel', '', 'drama', DateTime.now().subtract(Duration(days: 100))),
      ]),
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
