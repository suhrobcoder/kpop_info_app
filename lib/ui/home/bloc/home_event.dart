part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class TabClickEvent extends HomeEvent {
  final int tab;

  TabClickEvent(this.tab);
}
