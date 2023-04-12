part of 'group_discography_bloc.dart';

@immutable
abstract class GroupDiscographyState {}

class GroupDiscographyLoadingState extends GroupDiscographyState {}

class GroupDiscographyErrorState extends GroupDiscographyState {
  final String error;

  GroupDiscographyErrorState(this.error);
}

class GroupDiscographySuccessState extends GroupDiscographyState {
  final List<Album> albums;

  GroupDiscographySuccessState(this.albums);
}
