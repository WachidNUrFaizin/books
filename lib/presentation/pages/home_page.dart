import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutenberg/bloc/books/books_bloc.dart';
import 'package:gutenberg/bloc/books/books_event.dart';
import 'package:gutenberg/bloc/books/books_state.dart';
import 'package:gutenberg/bloc/favorites/favorites_bloc.dart';
import 'package:gutenberg/bloc/favorites/favorites_event.dart';
import 'package:gutenberg/bloc/favorites/favorites_state.dart';
import 'package:gutenberg/data/models/book_model.dart';
import 'package:gutenberg/presentation/widgets/book_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  void _fetchBooks([String query = '']) {

    context.read<BooksBloc>().add(FetchBooksEvent(query: query));
  }

  Future<void> _onRefresh() async {
    _fetchBooks(searchQuery);
  }

  void _showSearchDialog() async {
    final result = await showDialog<String>(
        context: context,
        builder: (ctx) {
          String localQuery = searchQuery;
          return AlertDialog(
            title: const Text('Search Books'),
            content: TextField(
              onChanged: (val) {
                localQuery = val;
              },
              decoration: const InputDecoration(
                  hintText: 'Enter book title or author'
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, localQuery),
                child: const Text('Search'),
              ),
            ],
          );
        }
    );
    if (result != null) {
      setState(() {
        searchQuery = result;
      });
      _fetchBooks(searchQuery);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gutenberg Books'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          )
        ],
      ),
      body: BlocBuilder<BooksBloc, BooksState>(
        builder: (context, state) {
          if (state is BooksLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BooksLoaded) {
            final books = state.books;
            return BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, favState) {
                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      final isFavorite = favState.favorites.contains(book);

                      return BookListItem(
                        book: book,
                        isFavorite: isFavorite,
                        onFavoriteToggle: () {
                          if (isFavorite) {
                            context.read<FavoritesBloc>().add(RemoveFavoriteEvent(book));
                          } else {
                            context.read<FavoritesBloc>().add(AddFavoriteEvent(book));
                          }
                        },
                        onTap: () {
                          Navigator.pushNamed(context, '/detail', arguments: book);
                        },
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is BooksError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showSearchDialog,
        child: const Icon(Icons.search),
      ),
    );
  }
}
