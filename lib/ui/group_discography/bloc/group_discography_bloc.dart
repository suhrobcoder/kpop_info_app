import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kpop_info/data/api/response/album.dart';
import 'package:kpop_info/domain/model/group.dart';
import 'package:kpop_info/domain/repository/discography_repository.dart';
import 'package:meta/meta.dart';

part 'group_discography_event.dart';
part 'group_discography_state.dart';

@injectable
class GroupDiscographyBloc
    extends Bloc<GroupDiscographyEvent, GroupDiscographyState> {
  final Group group;
  final DiscographyRepository repository;

  GroupDiscographyBloc(this.repository, @factoryParam this.group)
      : super(GroupDiscographyLoadingState()) {
    on<LoadEvent>((event, emit) {
      load();
    });
    add(LoadEvent());
  }

  void load() async {
    (await repository.getArtistAlbums(group.name)).fold(
      (l) => add(_AlbumsLoadedEvent(l)),
      (r) => add(_ErrorEvent(r)),
    );
  }
}

class _AlbumsLoadedEvent extends GroupDiscographyEvent {
  final List<Album> albums;

  _AlbumsLoadedEvent(this.albums);
}

class _ErrorEvent extends GroupDiscographyEvent {
  final String message;

  _ErrorEvent(this.message);
}
