import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kpop_info/di/init_get_it.dart';
import 'package:kpop_info/domain/model/group.dart';
import 'package:kpop_info/ui/group_details/group_details_page.dart';
import 'package:kpop_info/ui/group_list/bloc/group_list_bloc.dart';
import 'package:kpop_info/util/filter_type.dart';

class GroupListPage extends StatelessWidget {
  const GroupListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GroupListBloc>(),
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Kpop Xplore"),
        ),
        child: SafeArea(
          child: BlocBuilder<GroupListBloc, GroupListState>(
            builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CupertinoSearchTextField(
                      controller: state.searchController,
                      placeholder: "Search",
                      onSubmitted: (value) =>
                          context.read<GroupListBloc>().add(SearchEvent(value)),
                      onSuffixTap: () =>
                          context.read<GroupListBloc>().add(OnClearEvent()),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoSegmentedControl(
                      children: const {
                        FilterType.all: Text("All"),
                        FilterType.male: Text("Male"),
                        FilterType.female: Text("Female"),
                      },
                      groupValue: state.filterType,
                      onValueChanged: (type) => context
                          .read<GroupListBloc>()
                          .add(ChangeFilterType(type)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: PagedListView(
                      pagingController: state.pagingController,
                      builderDelegate: PagedChildBuilderDelegate<Group>(
                        itemBuilder: (context, group, index) {
                          return CupertinoListTile.notched(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            title: Text(group.name),
                            leading: CachedNetworkImage(
                              imageUrl: group.image ?? "",
                            ),
                            onTap: () => Navigator.of(context).push(
                              CupertinoPageRoute(
                                  title: group.name,
                                  builder: (context) =>
                                      GroupDetailsPage(group: group)),
                            ),
                          );
                        },
                        firstPageProgressIndicatorBuilder: (_) =>
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
      ),
    );
  }
}
