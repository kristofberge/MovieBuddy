import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_buddy/exceptions/api_exception.dart';
import 'package:movie_buddy/repos/genres_repository.dart';
import '../mocks.dart';
import 'package:matcher/matcher.dart';

void main() {
  MockClient client;
  MockUriBuilder uriBuilder;
  TmdbGenresRepository genresRepo;

  setUp(() {
    client = MockClient();
    uriBuilder = MockUriBuilder();
    genresRepo = TmdbGenresRepository(client, uriBuilder);
  });

  group('genres', () {
    String responseJson;
    List<Map<String, dynamic>> expectedMapList;
    setUp(() {
      responseJson = '{\"results\":[{\"key1\":\"value1\"},{\"key2\":\"value2\"}]}';
      expectedMapList = [
        {'key1': 'value1'},
        {'key2': 'value2'}
      ];
      when(uriBuilder.getGenresUri()).thenReturn(Uri());
    });

    test('response 200 returns list', () async {
      when(client.get(any)).thenAnswer((_) => Future.value(Response(responseJson, 200)));
      var mapList = await genresRepo.getGenres();
      expect(mapList, expectedMapList);
    });

    test('response 201 returns list', () async {
      when(client.get(any)).thenAnswer((_) => Future.value(Response(responseJson, 201)));
      var mapList = await genresRepo.getGenres();
      expect(mapList, expectedMapList);
    });

    test('unsucessfull response throws ApiException', () async {
      when(client.get(any)).thenAnswer((_) => Future.value(Response('body', 400)));
      expect(
        () async => await genresRepo.getGenres(),
        throwsA(
          isA<ApiException>().having(
            (ex) => ex.message,
            'message',
            'Error getting genres',
          ),
        ),
      );
    });
  });
}
