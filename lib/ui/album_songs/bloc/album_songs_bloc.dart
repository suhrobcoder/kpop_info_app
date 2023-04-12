import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kpop_info/data/api/response/album.dart';
import 'package:kpop_info/data/api/response/track.dart';
import 'package:kpop_info/domain/repository/discography_repository.dart';
import 'package:meta/meta.dart';

part 'album_songs_event.dart';
part 'album_songs_state.dart';

@injectable
class AlbumSongsBloc extends Bloc<AlbumSongsEvent, AlbumSongsState> {
  final Album album;
  final DiscographyRepository repository;

  AlbumSongsBloc(this.repository, @factoryParam this.album)
      : super(AlbumSongsLoadingState()) {
    on<_TracksLoadedEvent>((event, emit) {
      emit(AlbumSongsSuccessState(event.tracks));
    });
    on<_ErrorEvent>((event, emit) {
      emit(AlbumSongsErrorState(event.message));
    });
    load();
  }

  void load() async {
    (await repository.getAlbumTracks(album.id)).fold(
      (l) => add(_TracksLoadedEvent(l)),
      (r) => add(_ErrorEvent(r)),
    );
  }
}

class _TracksLoadedEvent extends AlbumSongsEvent {
  final List<Track> tracks;

  _TracksLoadedEvent(this.tracks);
}

class _ErrorEvent extends AlbumSongsEvent {
  final String message;

  _ErrorEvent(this.message);
}
