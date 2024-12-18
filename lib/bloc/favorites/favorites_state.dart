import 'package:equatable/equatable.dart';
import 'package:gutenberg/data/models/book_model.dart';

class FavoritesState extends Equatable {
  final List<Book> favorites;

  const FavoritesState({this.favorites = const []});

  FavoritesState copyWith({List<Book>? favorites}) {
    return FavoritesState(favorites: favorites ?? this.favorites);
  }

  @override
  List<Object?> get props => [favorites];
}
