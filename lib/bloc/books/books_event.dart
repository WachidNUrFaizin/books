// books_event.dart
import 'package:equatable/equatable.dart';

abstract class BooksEvent extends Equatable {
  const BooksEvent();
  @override
  List<Object?> get props => [];
}

class FetchBooksEvent extends BooksEvent {
  final String query;
  const FetchBooksEvent({this.query = ''});

  @override
  List<Object?> get props => [query];
}
