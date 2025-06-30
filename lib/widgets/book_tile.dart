import 'package:flutter/material.dart';
import '../models/book.dart';

class BookTile extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookTile({required this.book, required this.onTap, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('by ${book.author}'),
                ],
              ),
            ),
            SizedBox(width: 12),
            book.imageUrl != null
                ? Container(
                  height: 100,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 2,
                        offset: Offset(0, -1),
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(book.imageUrl!),
                      fit: BoxFit.contain,
                    ),
                  ),
                )
                : Container(width: 100, height: 130, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
