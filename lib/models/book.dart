
class Book {
  final String id;
  final String title;
  final String author;
  final String? summary;
  final List<String> subjects;
  final List<String> bookshelves;
  final String? imageUrl;

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.summary,
    required this.subjects,
    required this.bookshelves,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'summary': summary,
      'subjects': subjects,
      'bookshelves': bookshelves,
      'imageUrl': imageUrl,
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      summary: json['summary'],
      subjects: List<String>.from(json['subjects']),
      bookshelves: List<String>.from(json['bookshelves']),
      imageUrl: json['imageUrl'],
    );
  }
}
