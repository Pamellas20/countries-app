import 'package:equatable/equatable.dart';

class SearchBarState extends Equatable {
  const SearchBarState({this.query = '', this.hasText = false});

  final String query;
  final bool hasText;

  SearchBarState copyWith({String? query, bool? hasText}) {
    return SearchBarState(
      query: query ?? this.query,
      hasText: hasText ?? this.hasText,
    );
  }

  @override
  List<Object> get props => [query, hasText];
}
