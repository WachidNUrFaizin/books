import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutenberg/bloc/favorites/favorites_bloc.dart';
import 'package:gutenberg/bloc/favorites/favorites_event.dart';
import 'package:gutenberg/bloc/favorites/favorites_state.dart';
import 'package:gutenberg/data/models/book_model.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Book book = ModalRoute.of(context)?.settings.arguments as Book;

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, favState) {
          final isFavorite = favState.favorites.contains(book);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  book.title,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'By: ${book.authors.join(', ')}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    if (isFavorite) {
                      context.read<FavoritesBloc>().add(RemoveFavoriteEvent(book));
                    } else {
                      context.read<FavoritesBloc>().add(AddFavoriteEvent(book));
                    }
                  },
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                  label: Text(isFavorite ? 'Remove from Favorites' : 'Add to Favorites'),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
