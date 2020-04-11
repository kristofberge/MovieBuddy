import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_buddy/blocs/bloc.dart';
import 'package:movie_buddy/pages/home_page.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'util/injector.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintLayerBordersEnabled = true;
  Injector.injector.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: BlocProvider(
        child: HomePage(),
        create: (context) => kiwi.Container().resolve<MoviesBloc>(),
      ),
    );
  }
}
