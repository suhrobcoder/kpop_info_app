part of 'idol_list_bloc.dart';

@immutable
abstract class IdolListEvent {}

class SearchEvent extends IdolListEvent {
  final String query;

  SearchEvent(this.query);
}

class OnClearEvent extends IdolListEvent {}

class ChangeFilterType extends IdolListEvent {
  final FilterType filterType;

  ChangeFilterType(this.filterType);
}
