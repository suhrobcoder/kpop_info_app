import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop_info/di/init_get_it.dart';
import 'package:kpop_info/domain/model/group.dart';
import 'package:kpop_info/ui/album_songs/album_songs_page.dart';
import 'package:kpop_info/ui/group_discography/bloc/group_discography_bloc.dart';

class GroupDiscographyPage extends StatelessWidget {
  final Group group;

  const GroupDiscographyPage({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GroupDiscographyBloc>(param1: group),
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Discography"),
        ),
        child: BlocBuilder<GroupDiscographyBloc, GroupDiscographyState>(
          builder: (context, state) {
            return state is GroupDiscographySuccessState
                ? ListView.builder(
                    itemCount: state.albums.length,
                    itemBuilder: (context, position) {
                      final album = state.albums[position];
                      return CupertinoListTile(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        leadingSize: 64,
                        leading: CachedNetworkImage(
                          imageUrl: album.image ?? "",
                          width: 96,
                          height: 96,
                        ),
                        title: Text(
                          album.name,
                          style: const TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                          album.releaseDate.split('-').first,
                          style: const TextStyle(fontSize: 16),
                        ),
                        onTap: () => Navigator.of(context).push(
                            CupertinoPageRoute(
                                builder: (context) =>
                                    AlbumSongsPage(album: album))),
                      );
                    })
                : state is GroupDiscographyLoadingState
                    ? const Center(child: CupertinoActivityIndicator())
                    : Column();
          },
        ),
      ),
    );
  }
}
