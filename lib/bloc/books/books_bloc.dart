// books_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'books_event.dart';
import 'books_state.dart';
import 'package:gutenberg/data/repositories/books_repository.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final BooksRepository repository;

  BooksBloc(this.repository) : super(BooksInitial()) {
    on<FetchBooksEvent>((event, emit) async {
      emit(BooksLoading());
      try {
        final books = await repository.fetchBooks(event.query);
        emit(BooksLoaded(books));
      } catch (e) {
        emit(BooksError('Failed to fetch books'));
      }
    });
  }
}
