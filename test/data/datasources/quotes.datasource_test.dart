import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:quote_app/data/datasources/quotes.datasource.dart';

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  QuotesDatasourceImpl? datasource;
  MockHttpClient? mockHttpClient;
  setUpAll(() {
    mockHttpClient = MockHttpClient();
    datasource = QuotesDatasourceImpl(client: mockHttpClient!);
  });

  test('Should get all quotes from the remote api', () async {
    //arrange
    when(mockHttpClient?.get(Uri.parse('')))
        .thenAnswer((_) async => http.Response(fixture('quotes.json'), 200));

    //act
    final result = await datasource?.getQuotes(1, 10);

    //assert
    expect(result?.quotes.isNotEmpty, true);
  });
}
