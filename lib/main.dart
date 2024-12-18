import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutenberg/bloc/books/books_bloc.dart';
import 'package:gutenberg/bloc/favorites/favorites_bloc.dart';
import 'package:gutenberg/data/repositories/books_repository.dart';
import 'package:gutenberg/presentation/pages/favorites_page.dart';
import 'package:gutenberg/presentation/pages/home_page.dart';
import 'package:gutenberg/presentation/pages/book_detail_page.dart';

void main() {
  final booksRepository = BooksRepository();
  runApp(MyApp(booksRepository: booksRepository));
}

class MyApp extends StatelessWidget {
  final BooksRepository booksRepository;
  const MyApp({Key? key, required this.booksRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BooksBloc>(
          create: (context) => BooksBloc(booksRepository),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => FavoritesBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Gutenberg Books',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/favorites': (context) => const FavoritesPage(),
          '/detail': (context) => const BookDetailPage(),
        },
      ),
    );
  }
}
