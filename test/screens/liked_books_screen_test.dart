import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:palmcode/models/book.dart';
import 'package:palmcode/providers/book_provider.dart';
import 'package:palmcode/screens/liked_books_screen.dart';

void main() {
  testWidgets('Displays liked books correctly', (WidgetTester tester) async {
    final testBook = Book(
      id: '1',
      title: 'Liked Book',
      author: 'Author',
      summary: 'Summary',
      subjects: [],
      bookshelves: [],
      imageUrl: null,
    );

    final provider = BookProvider();
    provider.toggleLike(testBook);

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: MaterialApp(home: LikedBooksScreen()),
      ),
    );

    await tester.pump();

    expect(find.text('Liked Book'), findsOneWidget);
    expect(find.text('No liked books yet.'), findsNothing);
  });
}
