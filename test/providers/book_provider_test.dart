import 'package:flutter_test/flutter_test.dart';
import 'package:palmcode/models/book.dart';
import 'package:palmcode/providers/book_provider.dart';

void main() {
  group('BookProvider Test', () {
    late BookProvider provider;
    final testBook = Book(
      id: '1',
      title: 'Test Book',
      author: 'Test Author',
      summary: 'Summary',
      subjects: ['Fiction'],
      bookshelves: ['Test'],
      imageUrl: null,
    );

    setUp(() {
      provider = BookProvider();
    });

    test('should add and remove liked book', () {
      expect(provider.likedBooks.length, 0);

      provider.toggleLike(testBook);
      expect(provider.likedBooks.length, 1);
      expect(provider.isLiked(testBook), true);

      provider.toggleLike(testBook);
      expect(provider.likedBooks.length, 0);
      expect(provider.isLiked(testBook), false);
    });

    test('should filter books by search query', () {
      provider.listBook = [
        testBook,
        Book(
          id: '2',
          title: 'Flutter Guide',
          author: 'Dev',
          summary: '',
          subjects: [],
          bookshelves: [],
          imageUrl: null,
        )
      ];

      provider.setSearchQuery('flutter');
      expect(provider.books.length, 1);
      expect(provider.books[0].title, 'Flutter Guide');
    });
  });
}
