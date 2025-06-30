import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/book_provider.dart';
import '../services/book_api_service.dart';

class BookDetailScreen extends StatelessWidget {
  final String bookId;

  BookDetailScreen({required this.bookId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Book>(
      future: BookApiService.fetchBookDetail(bookId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final book = snapshot.data!;
        final provider = Provider.of<BookProvider>(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('Book Detail'),
            actions: [
              IconButton(
                icon: Icon(
                  provider.isLiked(book)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  provider.toggleLike(book);
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                if (book.imageUrl != null)
                  Image.network(book.imageUrl!, height: 200),
                SizedBox(height: 12),
                Text(
                  book.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'by ${book.author}',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 12),
                if (book.summary != null) Text(book.summary!),
                SizedBox(height: 24),
                Text(
                  'Subjects: ${book.subjects.join(', ')}',
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: 10),
                Text(
                  'Bookshelves: ${book.bookshelves.join(', ')}',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
