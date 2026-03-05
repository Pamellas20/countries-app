import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/country_summary.dart';
import '../../domain/repositories/countries_repository.dart';
import '../../../favorites/domain/repositories/favorites_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._countriesRepository, this._favoritesRepository)
    : super(const HomeInitial());

  final CountriesRepository _countriesRepository;
  final FavoritesRepository _favoritesRepository;
  Timer? _debounceTimer;

  List<CountrySummary> _allCountries = [];
  static const int _pageSize = 20;

  Future<void> loadCountries() async {
    emit(const HomeLoading());

    final result = await _countriesRepository.getAllCountries();
    result.fold(
      (failure) => emit(HomeError(failure.message ?? 'Unknown error')),
      (countries) {
        if (countries.isEmpty) {
          emit(const HomeEmpty());
        } else {
          _allCountries = countries;
          final initialCountries = countries.take(_pageSize).toList();
          emit(
            HomeLoaded(
              initialCountries,
              hasReachedMax: countries.length <= _pageSize,
            ),
          );
        }
      },
    );
  }

  Future<void> loadMoreCountries() async {
    final currentState = state;
    if (currentState is! HomeLoaded) return;
    if (currentState.hasReachedMax || currentState.isLoadingMore) return;

    emit(currentState.copyWith(isLoadingMore: true));

    // Simulate network delay for smooth UX
    await Future.delayed(const Duration(milliseconds: 500));

    final currentLength = currentState.countries.length;
    final moreCountries = _allCountries
        .skip(currentLength)
        .take(_pageSize)
        .toList();

    if (moreCountries.isEmpty) {
      emit(currentState.copyWith(isLoadingMore: false, hasReachedMax: true));
    } else {
      emit(
        currentState.copyWith(
          countries: [...currentState.countries, ...moreCountries],
          isLoadingMore: false,
          hasReachedMax:
              currentLength + moreCountries.length >= _allCountries.length,
        ),
      );
    }
  }

  Future<void> searchCountries(String query) async {
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      loadCountries();
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      emit(const HomeLoading());

      final result = await _countriesRepository.searchCountries(query);
      result.fold(
        (failure) => emit(HomeError(failure.message ?? 'Unknown error')),
        (countries) {
          if (countries.isEmpty) {
            emit(const HomeEmpty());
          } else {
            _allCountries = countries;
            final initialCountries = countries.take(_pageSize).toList();
            emit(
              HomeLoaded(
                initialCountries,
                hasReachedMax: countries.length <= _pageSize,
              ),
            );
          }
        },
      );
    });
  }

  Future<void> toggleFavorite(String cca2) async {
    await _favoritesRepository.toggleFavorite(cca2);
  }

  Future<bool> isFavorite(String cca2) async {
    final result = await _favoritesRepository.isFavorite(cca2);
    return result.fold((_) => false, (favorite) => favorite);
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
