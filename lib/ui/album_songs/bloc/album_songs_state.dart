part of 'album_songs_bloc.dart';

@immutable
abstract class AlbumSongsState {}

class AlbumSongsLoadingState extends AlbumSongsState {}

class AlbumSongsErrorState extends AlbumSongsState {
  final String error;

  AlbumSongsErrorState(this.error);
}

class AlbumSongsSuccessState extends AlbumSongsState {
  final List<Track> tracks;

  AlbumSongsSuccessState(this.tracks);
}
