
import 'package:flutter/material.dart';
import '../models/book.dart';

class BookTile extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookTile({required this.book, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: book.imageUrl != null
          ? Image.network(book.imageUrl!, width: 50, height: 50, fit: BoxFit.cover)
          : Container(width: 50, height: 50, color: Colors.grey),
      title: Text(book.title),
      subtitle: Text(book.author),
      onTap: onTap,
    );
  }
}
