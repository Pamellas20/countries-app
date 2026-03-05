import 'package:countries_app/core/error/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/country_details_repository.dart';
import '../../../favorites/domain/repositories/favorites_repository.dart';
import 'country_details_state.dart';

class CountryDetailsCubit extends Cubit<CountryDetailsState> {
  CountryDetailsCubit(this._countryDetailsRepository, this._favoritesRepository)
    : super(const CountryDetailsInitial());

  final CountryDetailsRepository _countryDetailsRepository;
  final FavoritesRepository _favoritesRepository;

  Future<void> loadCountryDetails(String cca2) async {
    emit(const CountryDetailsLoading());

    final result = await _countryDetailsRepository.getCountryDetails(cca2);
    result.fold(
      (Failure failure) =>
          emit(CountryDetailsError(failure.message ?? 'Unknown error')),
      (countryDetails) => emit(CountryDetailsLoaded(countryDetails)),
    );
  }

  Future<void> toggleFavorite(String cca2) async {
    await _favoritesRepository.toggleFavorite(cca2);
  }
}
