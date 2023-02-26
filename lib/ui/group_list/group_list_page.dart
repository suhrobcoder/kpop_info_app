import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kpop_info/di/init_get_it.dart';
import 'package:kpop_info/domain/model/group.dart';
import 'package:kpop_info/ui/group_list/bloc/group_list_bloc.dart';

class GroupListPage extends StatelessWidget {
  const GroupListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GroupListBloc>(),
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Kpop Info"),
        ),
        child: BlocBuilder<GroupListBloc, GroupListState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: PagedListView(
                    pagingController: state.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Group>(
                      itemBuilder: (context, group, index) {
                        return CupertinoListTile(
                          title: Text(group.name),
                          leading: CachedNetworkImage(
                            imageUrl: group.image ?? "",
                          ),
                          onTap: () {},
                        );
                      },
                      firstPageErrorIndicatorBuilder: (_) =>
                          const CupertinoActivityIndicator(),
                      newPageProgressIndicatorBuilder: (_) =>
                          const CupertinoActivityIndicator(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}