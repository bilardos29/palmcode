import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class BookApiService {
  static const String baseUrl = 'https://gutendex.com/books';

  static Future<List<Book>> fetchBookList(int page) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/?page=$page'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final books = data['results'] as List;
        return books.map((json) {
          return Book(
            id: json['id'].toString(),
            title: json['title'] ?? '',
            author: (json['authors'] as List).isNotEmpty
                ? json['authors'][0]['name'] ?? ''
                : 'Unknown',
            summary: (json['summaries'] as List).isNotEmpty
                ? json['summaries'][0] ?? ''
                : null,
            subjects: List<String>.from(json['subjects'] ?? []),
            bookshelves: List<String>.from(json['bookshelves'] ?? []),
            imageUrl: json['formats']?['image/jpeg'],
          );
        }).toList();
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
      }
    } on TimeoutException catch (_) {
      throw Exception('Request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<List<Book>> fetchSearchBook(String query) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/?search=$query'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final books = data['results'] as List;
        return books.map((json) {
          return Book(
            id: json['id'].toString(),
            title: json['title'] ?? '',
            author: (json['authors'] as List).isNotEmpty
                ? json['authors'][0]['name'] ?? ''
                : 'Unknown',
            summary: (json['summaries'] as List).isNotEmpty
                ? json['summaries'][0] ?? ''
                : null,
            subjects: List<String>.from(json['subjects'] ?? []),
            bookshelves: List<String>.from(json['bookshelves'] ?? []),
            imageUrl: json['formats']?['image/jpeg'],
          );
        }).toList();
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
      }
    } on TimeoutException catch (_) {
      throw Exception('Request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<Book> fetchBookDetail(String id) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/$id'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Book(
          id: json['id'].toString(),
          title: json['title'] ?? '',
          author: (json['authors'] as List).isNotEmpty
              ? json['authors'][0]['name'] ?? ''
              : 'Unknown',
          summary: (json['summaries'] as List).isNotEmpty
              ? json['summaries'][0] ?? ''
              : null,
          subjects: List<String>.from(json['subjects'] ?? []),
          bookshelves: List<String>.from(json['bookshelves'] ?? []),
          imageUrl: json['formats']?['image/jpeg'],
        );
      } else {
        throw Exception('Failed to load book detail: ${response.statusCode}');
      }
    } on TimeoutException catch (_) {
      throw Exception('Request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
