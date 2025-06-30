import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';
import 'package:palmcode/services/book_api_service.dart';

void main() {
  group('BookApiService.fetchBookList', () {
    test('returns list of books on success', () async {
      final mockClient = MockClient((request) async {
        return http.Response(jsonEncode({
          'results': [
            {
              'id': 1,
              'title': 'Mock Book',
              'authors': [{'name': 'Author'}],
              'summaries': ['A book.'],
              'subjects': ['Fiction'],
              'bookshelves': ['Shelf'],
              'formats': {'image/jpeg': null}
            }
          ]
        }), 200);
      });

      http.Client replacement = mockClient;

      final books = await BookApiService.fetchBookList(1);
      expect(books, isA<List>());
      expect(books.first.title, 'Mock Book');
    });

    test('throws exception on error', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Internal Error', 500);
      });

      http.Client replacement = mockClient;

      expect(() async => await BookApiService.fetchBookList(1), throwsException);
    });
  });
}
