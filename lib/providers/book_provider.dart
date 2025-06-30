
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/book.dart';
import '../services/book_api_service.dart';

class BookProvider with ChangeNotifier {
  List<Book> listBook = [];
  List<Book> searchBook = [];
  List<Book> _likedBooks = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<Book> get books => _searchQuery.isEmpty
      ? listBook
      : searchBook;

  List<Book> get likedBooks => _likedBooks;
  bool get isLoading => _isLoading;

  Future<void> setSearchQuery(String query) async {
    _searchQuery = query;
    notifyListeners();
    if(query.isNotEmpty) {
      _isLoading = true;
      notifyListeners();

      try {
        searchBook = await BookApiService.fetchSearchBook(query);
      } catch (e) {
        listBook = [];
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> fetchBooks() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getStringList('liked_books') ?? [];

      _likedBooks = saved
          .map((json) => Book.fromJson(jsonDecode(json)))
          .toList();

      listBook = await BookApiService.fetchBookList(1);
    } catch (e) {
      listBook = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchNextListBooks() async {
    _isLoading = true;
    notifyListeners();

    try {
      listBook = await BookApiService.fetchBookList(2);
    } catch (e) {
      listBook = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleLike(Book book) {
    if (_likedBooks.any((b) => b.id == book.id)) {
      _likedBooks.removeWhere((b) => b.id == book.id);
    } else {
      _likedBooks.add(book);
    }
    saveLikedBooks();
    notifyListeners();
  }

  bool isLiked(Book book) {
    return _likedBooks.any((b) => b.id == book.id);
  }

  Future<void> saveLikedBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _likedBooks.map((b) => jsonEncode(b.toJson())).toList();
    prefs.setStringList('liked_books', data);
  }
}
