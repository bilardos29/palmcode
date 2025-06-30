
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../widgets/book_tile.dart';
import 'book_detail_screen.dart';

class LikedBooksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final likedBooks = Provider.of<BookProvider>(context).likedBooks;

    return Scaffold(
      body: likedBooks.isEmpty
          ? Center(child: Text('No liked books yet.'))
          : ListView.builder(
              itemCount: likedBooks.length,
              itemBuilder: (context, index) {
                final book = likedBooks[index];
                return BookTile(
                  book: book,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookDetailScreen(bookId: book.id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
