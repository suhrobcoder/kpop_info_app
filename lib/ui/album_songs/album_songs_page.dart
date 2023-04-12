import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop_info/data/api/response/album.dart';
import 'package:kpop_info/data/api/response/track.dart';
import 'package:kpop_info/di/init_get_it.dart';
import 'package:kpop_info/ui/album_songs/bloc/album_songs_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AlbumSongsPage extends StatelessWidget {
  final Album album;

  const AlbumSongsPage({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AlbumSongsBloc>(param1: album),
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(album.name),
        ),
        child: BlocBuilder<AlbumSongsBloc, AlbumSongsState>(
          builder: (context, state) {
            return state is AlbumSongsSuccessState
                ? ListView.builder(
                    itemCount: state.tracks.length,
                    itemBuilder: (context, position) {
                      final track = state.tracks[position];
                      return CupertinoListTile.notched(
                        title: Text(track.name),
                        onTap: () => openTrackOnSpotify(track),
                      );
                    },
                  )
                : state is AlbumSongsLoadingState
                    ? const Center(child: CupertinoActivityIndicator())
                    : Column();
          },
        ),
      ),
    );
  }

  void openTrackOnSpotify(Track track) async {
    final url = "https://open.spotify.com/track/${track.id}";
    if (await canLaunchUrlString(url)) {
      launchUrlString(url);
    }
  }
}
