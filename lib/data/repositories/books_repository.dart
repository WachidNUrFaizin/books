// books_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book_model.dart';

class BooksRepository {
  final String baseUrl = 'https://gutendex.com/books';

  Future<List<Book>> fetchBooks([String query = '']) async {
    final url = query.isEmpty
        ? Uri.parse(baseUrl)
        : Uri.parse('$baseUrl?search=$query');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;
      return results.map((bookJson) => Book.fromJson(bookJson)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
