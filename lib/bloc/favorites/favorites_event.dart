import 'package:equatable/equatable.dart';
import 'package:gutenberg/data/models/book_model.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class AddFavoriteEvent extends FavoritesEvent {
  final Book book;
  const AddFavoriteEvent(this.book);

  @override
  List<Object?> get props => [book];
}

class RemoveFavoriteEvent extends FavoritesEvent {
  final Book book;
  const RemoveFavoriteEvent(this.book);

  @override
  List<Object?> get props => [book];
}
