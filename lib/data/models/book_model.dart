class Book {
  final int id;
  final String title;
  final List<String> authors;

  Book({required this.id, required this.title, required this.authors});

  factory Book.fromJson(Map<String, dynamic> json) {
    final authorsList = (json['authors'] as List)
        .map((authorJson) => authorJson['name'] as String)
        .toList();

    return Book(
      id: json['id'] as int,
      title: json['title'] as String,
      authors: authorsList,
    );
  }
}
