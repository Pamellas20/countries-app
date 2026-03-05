import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_bar_state.dart';

class SearchBarCubit extends Cubit<SearchBarState> {
  SearchBarCubit() : super(const SearchBarState());

  void updateQuery(String query) {
    emit(state.copyWith(query: query, hasText: query.isNotEmpty));
  }

  void clearQuery() {
    emit(const SearchBarState());
  }
}
