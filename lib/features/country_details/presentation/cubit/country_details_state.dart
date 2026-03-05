import 'package:equatable/equatable.dart';
import '../../domain/entities/country_details.dart';

abstract class CountryDetailsState extends Equatable {
  const CountryDetailsState();

  @override
  List<Object> get props => [];
}

class CountryDetailsInitial extends CountryDetailsState {
  const CountryDetailsInitial();
}

class CountryDetailsLoading extends CountryDetailsState {
  const CountryDetailsLoading();
}

class CountryDetailsLoaded extends CountryDetailsState {
  const CountryDetailsLoaded(this.countryDetails);

  final CountryDetails countryDetails;

  @override
  List<Object> get props => [countryDetails];
}

class CountryDetailsError extends CountryDetailsState {
  const CountryDetailsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}