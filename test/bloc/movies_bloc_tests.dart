// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_buddy/bloc/bloc.dart';
import 'package:movie_buddy/bloc/movies_bloc.dart';
import 'package:movie_buddy/models/movie_model.dart';

import 'package:mockito/mockito.dart';

import '../mocks.dart';

void main() {
  MoviesBloc moviesbloc;
  MockMoviesRepository moviesRepo;
  MockMapper mapper;

  setUp(() {
    moviesRepo = MockMoviesRepository();
    mapper = MockMapper();
    moviesbloc = MoviesBloc(moviesRepo, mapper);
  });

  test('initial state is correct', () {
    expect(moviesbloc.initialState, InitialMoviesState());
  });

  test('dispose does not emit new state', () {
    moviesbloc.dispose();
    expectLater(moviesbloc.state, emitsInOrder([]));
  });

  group('fetch upcoming movies', () {
    test('valid response from API', () {
      final List<Map<String, dynamic>> dummyMapsList = [
        {'key1': 'value1'},
        {'key2': 'value2'}
      ];
      final List<Movie> dummyMoviesList = [
        Movie('name1', Uri(), 'genre1', DateTime.now()),
        Movie('name2', Uri(), 'genre2', DateTime.now())
      ];

      when(moviesRepo.getUpcomingMovies()).thenAnswer((_) => Future.value(dummyMapsList));
      when(mapper.mapToMoviesList(dummyMapsList)).thenReturn(dummyMoviesList);

      moviesbloc.dispatch(LoadUpcomingMovies());

      expectLater(moviesbloc.state, emitsInOrder([InitialMoviesState(), IsLoading(), MoviesLoaded(dummyMoviesList)]));
    });

    // test('catch API exception', () {
    //   expectLater(moviesbloc.state, neverEmits([MoviesLoaded(List<Movie>())]));
    //   when(moviesRepo.getUpcomingMovies()).thenThrow(ApiException('API error'));
    //   moviesbloc.dispatch(LoadUpcomingMovies());
      
    // });
  });
}

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }
