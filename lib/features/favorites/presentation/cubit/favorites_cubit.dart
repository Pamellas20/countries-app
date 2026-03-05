import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/favorites_repository.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._favoritesRepository) : super(const FavoritesInitial());

  final FavoritesRepository _favoritesRepository;

  Future<void> loadFavorites() async {
    emit(const FavoritesLoading());

    final result = await _favoritesRepository.getFavorites();
    result.fold(
      (failure) => emit(FavoritesError(failure.message ?? 'Unknown error')),
      (favorites) => favorites.isEmpty
          ? emit(const FavoritesEmpty())
          : emit(FavoritesLoaded(favorites)),
    );
  }

  Future<void> removeFavorite(String cca2) async {
    await _favoritesRepository.toggleFavorite(cca2);
    loadFavorites(); // Refresh the list
  }
}
