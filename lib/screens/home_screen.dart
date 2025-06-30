import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../widgets/book_tile.dart';
import 'book_detail_screen.dart';
import 'liked_books_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookProvider>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Book List'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.favorite),
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (_) => LikedBooksScreen()),
      //         );
      //       },
      //     )
      //   ],
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12).copyWith(top: 56),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search books...',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) =>
                  Provider.of<BookProvider>(context, listen: false)
                      .setSearchQuery(query),
            ),
          ),
          Expanded(
            child: provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: provider.books.length,
                    itemBuilder: (context, index) {
                      final book = provider.books[index];
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
          ),
        ],
      ),
    );
  }
}
