import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';
import 'package:gutenberg/data/models/book_model.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(const FavoritesState()) {
    on<AddFavoriteEvent>((event, emit) {
      final updatedList = List<Book>.from(state.favorites)..add(event.book);
      emit(state.copyWith(favorites: updatedList));
    });

    on<RemoveFavoriteEvent>((event, emit) {
      final updatedList = List<Book>.from(state.favorites)..remove(event.book);
      emit(state.copyWith(favorites: updatedList));
    });
  }
}
