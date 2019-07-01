import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_buddy/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:movie_buddy/util/mapper.dart';
import 'package:movie_buddy/util/uri_builder.dart';
import 'bloc/bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const _apiKey = '1f54bd990f1cdfb230adb312546d765d';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Buddy',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: BlocProvider(
        child: HomePage(),
        builder: (context) {
          final uriBuilder = UriBuilder(_apiKey);
          return MoviesBloc(http.Client(), uriBuilder, Mapper(uriBuilder));
        },
      ),
    );
  }
}
