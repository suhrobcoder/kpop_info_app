import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop_info/di/init_get_it.dart';
import 'package:kpop_info/domain/model/group.dart';
import 'package:kpop_info/ui/group_discography/bloc/group_discography_bloc.dart';

class GroupDiscographyPage extends StatelessWidget {
  final Group group;

  const GroupDiscographyPage({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GroupDiscographyBloc>(param1: group),
      child: CupertinoPageScaffold(
        child: BlocBuilder<GroupDiscographyBloc, GroupDiscographyState>(
          builder: (context, state) {
            return state is GroupDiscographySuccessState
                ? ListView.builder(itemBuilder: (context, position) {
                    final album = state.albums[position];
                    return CupertinoListTile.notched(title: Text(album.name));
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
