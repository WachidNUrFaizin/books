import 'package:flutter/material.dart';
import 'package:gutenberg/data/models/book_model.dart';

class BookListItem extends StatelessWidget {
  final Book book;
  final VoidCallback onFavoriteToggle;
  final bool isFavorite;
  final VoidCallback onTap;

  const BookListItem({
    Key? key,
    required this.book,
    required this.onFavoriteToggle,
    required this.isFavorite,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authors = book.authors.join(', ');
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      elevation: 2,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(8.0),
        title: Text(
          book.title,
          style: Theme.of(context).textTheme.titleLarge,

        ),
        subtitle: Text(authors),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : null,
          ),
          onPressed: onFavoriteToggle,
        ),
      ),
    );
  }
}
