import 'package:equatable/equatable.dart';
import '../../domain/entities/country_summary.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  const HomeLoaded(
    this.countries, {
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  final List<CountrySummary> countries;
  final bool hasReachedMax;
  final bool isLoadingMore;

  HomeLoaded copyWith({
    List<CountrySummary>? countries,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return HomeLoaded(
      countries ?? this.countries,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object> get props => [countries, hasReachedMax, isLoadingMore];
}

class HomeEmpty extends HomeState {
  const HomeEmpty();
}

class HomeError extends HomeState {
  const HomeError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
