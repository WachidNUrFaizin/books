import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutenberg/bloc/favorites/favorites_bloc.dart';
import 'package:gutenberg/bloc/favorites/favorites_state.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.favorites.isEmpty) {
            return const Center(child: Text('No favorites yet!'));
          }
          return ListView.builder(
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              final book = state.favorites[index];
              final authors = book.authors.join(', ');
              return ListTile(
                title: Text(book.title),
                subtitle: Text(authors),
              );
            },
          );
        },
      ),
    );
  }
}
