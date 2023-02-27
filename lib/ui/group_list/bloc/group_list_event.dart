part of 'group_list_bloc.dart';

@immutable
abstract class GroupListEvent {}

class SearchEvent extends GroupListEvent {
  final String query;

  SearchEvent(this.query);
}

class OnClearEvent extends GroupListEvent {}
